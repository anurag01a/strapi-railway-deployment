# =============================================================================
# ECS (ELASTIC CONTAINER SERVICE)
# =============================================================================
# ECS runs Docker containers using Fargate (serverless).

# -----------------------------------------------------------------------------
# ECS Cluster
# -----------------------------------------------------------------------------
resource "aws_ecs_cluster" "main" {
  name = "${local. name_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${local.name_prefix}-cluster"
  }
}

# -----------------------------------------------------------------------------
# CloudWatch Log Group
# -----------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "strapi" {
  name              = "/ecs/${local.name_prefix}-strapi"
  retention_in_days = 30

  tags = {
    Name = "${local.name_prefix}-logs"
  }
}

# -----------------------------------------------------------------------------
# ECS Task Definition
# -----------------------------------------------------------------------------
resource "aws_ecs_task_definition" "strapi" {
  family                   = "${local.name_prefix}-strapi"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role. ecs_execution.arn
  task_role_arn            = aws_iam_role. ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${aws_ecr_repository.strapi.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "NODE_ENV", value = "production" },
        { name = "DATABASE_CLIENT", value = "postgres" },
        { name = "DATABASE_HOST", value = aws_db_instance.main.address },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = var.db_name },
        { name = "DATABASE_USERNAME", value = var.db_username },
        { name = "DATABASE_PASSWORD", value = var.db_password },
        { name = "DATABASE_SSL", value = "false" },
        { name = "HOST", value = "0.0.0.0" },
        { name = "PORT", value = tostring(var.container_port) },
        { name = "APP_KEYS", value = var.strapi_app_keys },
        { name = "ADMIN_JWT_SECRET", value = var.strapi_admin_jwt_secret },
        { name = "JWT_SECRET", value = var.strapi_jwt_secret },
        { name = "API_TOKEN_SALT", value = var. strapi_api_token_salt }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.strapi.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "strapi"
        }
      }
    }
  ])

  tags = {
    Name = "${local.name_prefix}-task-definition"
  }
}

# -----------------------------------------------------------------------------
# ECS Service
# -----------------------------------------------------------------------------
resource "aws_ecs_service" "strapi" {
  name            = "${local.name_prefix}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private[*].id
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi.arn
    container_name   = "strapi"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.http]

  tags = {
    Name = "${local.name_prefix}-service"
  }
}