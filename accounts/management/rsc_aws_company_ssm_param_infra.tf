#------------------------------------------------------------------------------
# Create an EventBridge Trigger for the Lambda function 
#------------------------------------------------------------------------------
module "ssm_param_infra" {
  source = "git@github.com:christophefund/opentofu_aws_modules.git//ssm/ssm_param"             # refers to the last commited version on the default branch
  tags = merge(
    var.tags, {
      Product = "LandingZone",
      Tenant  = "Common",
      Name    = "infra-ssm-param-lz-home-region"
    }
  )

  name        = "/infra/general/lz_home_region"
  description = "Landing Zone Home Region"
  type        = "String"
  value       = "us-east-1"
  tier        = "Standard"
  #key_id      = "alias/aws/ssm"                                                               # or KMS key ARN or KMS Alias ARN

}
