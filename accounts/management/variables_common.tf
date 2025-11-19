
#------------------------------------------------------------------------------
# Resource Tags
#------------------------------------------------------------------------------
variable "tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Application = "my_demo_application",
    Environment = "dev"
    Owner       = "user@company.com"
  }
}

variable "aws_home_region" {
  description = "AWS Landing Zone Home Region"
  type        = string
  default     = "us-east-1"
  #default     = "eu-central-1"
}

#------------------------------------------------------------------------------
# Environment Prefix
# Objective : [app]-[env]-s3-[purpose]-[random] 
# Example   : myapp-prod-s3-logs-1a2b3c,  webapp-dev-ec2-appserver-01,
#             finance-prod-vpc, analytics-staging-lambda-dataIngest  
#------------------------------------------------------------------------------
variable "env_prefix" {
  description = "Environment Abbreviation Prefix"
  type        = string
  default     = "env_xyz"
}





#------------------------------------------------------------------------------
# S3 Bucket
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# KMS Key
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# DynamoDB Table
#------------------------------------------------------------------------------
