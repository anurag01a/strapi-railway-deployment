# =============================================================================
# OUTPUTS
# =============================================================================
# Outputs display important information after deployment.

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main. id
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "strapi_url" {
  description = "URL to access Strapi"
  value       = "http://${aws_lb.main. dns_name}"
}

output "strapi_admin_url" {
  description = "URL to access Strapi Admin"
  value       = "http://${aws_lb.main. dns_name}/admin"
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository. strapi.repository_url
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.main.endpoint
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}