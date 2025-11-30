# =============================================================================
# MAIN TERRAFORM CONFIGURATION
# =============================================================================
# This file contains local values and data sources used across the configuration.

# -----------------------------------------------------------------------------
# Local Values
# -----------------------------------------------------------------------------
# Locals are computed values that can be reused throughout the configuration

locals {
  # Naming prefix for all resources
  name_prefix = "${var.project_name}-${var.environment}"

  # Calculate subnet CIDR blocks dynamically
  # Public subnets: 10.0.1.0/24, 10.0. 2.0/24
  # Private subnets: 10.0.11.0/24, 10. 0.12.0/24
  public_subnet_cidrs  = [for i in range(var.availability_zone_count) : cidrsubnet(var.vpc_cidr, 8, i + 1)]
  private_subnet_cidrs = [for i in range(var.availability_zone_count) : cidrsubnet(var. vpc_cidr, 8, i + 11)]

  # Common tags
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

# -----------------------------------------------------------------------------
# Data Sources
# -----------------------------------------------------------------------------
# Data sources fetch information from AWS

# Get available availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Get current region
data "aws_region" "current" {}