#------------------------------------------------------------------------------
# Configure the Required Versions for Terraform and Providers
#------------------------------------------------------------------------------
terraform {

  required_version = "~> 1.10.7" # 2025.10 (Terraform 1.13.4, OpenTofu 1.10.7)

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.19.0" # 2025.10
    }
  }
}