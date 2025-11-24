
#------------------------------------------------------------------------------
# Resource Tags
#------------------------------------------------------------------------------
variable "tags" {
  type        = map(string)
  description = "Tags to set for all resources"

  default = {
    Terraform   = "true"
    Application = "my_demo_application",
    Environment = "dev"
    Owner       = "user@company.com"
  }
}

variable "aws_home_region" {
  type        = string
  description = "AWS Landing Zone Home Region"
  default     = "us-east-1" # "eu-central-1"
}

#------------------------------------------------------------------------------
# Environment Prefix
# Objective : [app]-[env]-s3-[purpose]-[random] 
# Example   : myapp-prod-s3-logs-1a2b3c,  webapp-dev-ec2-appserver-01,
#             finance-prod-vpc, analytics-staging-lambda-dataIngest  
#------------------------------------------------------------------------------
variable "env_prefix" {
  type        = string
  description = "Environment Abbreviation Prefix"
  default     = "env_xyz"
}