# =============================================================================
# ECR (ELASTIC CONTAINER REGISTRY)
# =============================================================================
# ECR stores Docker images privately in AWS.

resource "aws_ecr_repository" "strapi" {
  name                 = "${local.name_prefix}-strapi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = "${local.name_prefix}-strapi"
  }
}

# Lifecycle policy to clean up old images
resource "aws_ecr_lifecycle_policy" "strapi" {
  repository = aws_ecr_repository.strapi. name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}