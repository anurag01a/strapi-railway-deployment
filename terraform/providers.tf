# =============================================================================
# TERRAFORM PROVIDERS CONFIGURATION
# =============================================================================
# Providers are plugins that Terraform uses to interact with cloud platforms.
# This file configures the AWS provider. 

terraform {
  # Minimum Terraform version required
  required_version = ">= 1.0.0"

  # Required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region

  # Default tags applied to ALL resources created
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "strapi-deployment"
    }
  }
}