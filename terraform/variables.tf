# =============================================================================
# INPUT VARIABLES
# =============================================================================
# Variables allow you to customize the infrastructure without changing code.
# Think of them as parameters you pass to the configuration.

# -----------------------------------------------------------------------------
# General Configuration
# -----------------------------------------------------------------------------

variable "project_name" {
  description = "Name of the project - used in resource naming"
  type        = string
  default     = "strapi-cms"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be: dev, staging, or prod."
  }
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

# -----------------------------------------------------------------------------
# Network Configuration
# -----------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC - defines the IP address range"
  type        = string
  default     = "10.0. 0.0/16"
}

variable "availability_zone_count" {
  description = "Number of availability zones for high availability"
  type        = number
  default     = 2
}

# -----------------------------------------------------------------------------
# Database Configuration
# -----------------------------------------------------------------------------

variable "db_instance_class" {
  description = "RDS instance type - determines CPU and memory"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "strapidb"
}

variable "db_username" {
  description = "Master username for database"
  type        = string
  default     = "strapiuser"
  sensitive   = true
}

variable "db_password" {
  description = "Master password for database - must be at least 8 characters"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "Database password must be at least 8 characters."
  }
}

variable "db_storage" {
  description = "Allocated storage for database in GB"
  type        = number
  default     = 20
}

# -----------------------------------------------------------------------------
# ECS Configuration
# -----------------------------------------------------------------------------

variable "container_cpu" {
  description = "CPU units for container (1024 = 1 vCPU)"
  type        = number
  default     = 512
}

variable "container_memory" {
  description = "Memory for container in MB"
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Number of container instances to run"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Port the Strapi container listens on"
  type        = number
  default     = 1337
}

# -----------------------------------------------------------------------------
# Strapi Configuration
# -----------------------------------------------------------------------------

variable "strapi_app_keys" {
  description = "Strapi APP_KEYS - comma separated secrets"
  type        = string
  sensitive   = true
}

variable "strapi_admin_jwt_secret" {
  description = "Strapi ADMIN_JWT_SECRET"
  type        = string
  sensitive   = true
}

variable "strapi_jwt_secret" {
  description = "Strapi JWT_SECRET"
  type        = string
  sensitive   = true
}

variable "strapi_api_token_salt" {
  description = "Strapi API_TOKEN_SALT"
  type        = string
  sensitive   = true
}