terraform {
  /* Uncomment to use HCP Terraform
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-module-use"
    }
  }
  */


  #------------------------------------------------------------------------------
  # Stores the terraform.tfstate file on S3
  # Locking mechanism based on a Lock file in the same S3 bucket (No DynamoDB)
  #------------------------------------------------------------------------------
  /*
  backend "s3" {
    bucket  = "company-prod-s3-tfstate-f31d7fd6" # UNIQUE BUCKET NAME
    key     = "terraform/democompany/prod/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true # IF THE BUCKET POLICY ENFORCES ENCRYPTION AT REST, THIS IS MANDATORY TO BE SET TO TRUE
    #kms_key_id     = "alias/s3-terraform"
    profile      = "terraform-profile" # SINCE THE BACKEND BLOCK IS LOADED FIRST, AUTHENTICATION TO AWS HAPPENS THANKS TO AN AWS CLI PROFILE
    use_lockfile = true                # S3 NATIVE STATE LOCKING

    assume_role = {
      role_arn     = "arn:aws:iam::484353965144:role/s3-terraform-state-access" # ARN OF THE ROLE TO BE USED TO ACCESS THE S3 BUCKET IN THE CENTRAL TERRAFORM S3 BUCKET
      session_name = "terraform"
    }
  }
*/

  required_version = "~> 1.10.7" # 2025.10 (Terraform 1.13.4, OpenTofu 1.10.7)

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.19.0" # 2025.10
    }
  }
}
