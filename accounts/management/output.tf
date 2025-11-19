#------------------------------------------------------------------------------
# Region
#------------------------------------------------------------------------------
output "aws_region_name" {
  description = "AWS Region Name"
  value       = data.aws_region.current.region
}

output "aws_region_descn" {
  description = "AWS Region Description"
  value       = data.aws_region.current.description
}


#------------------------------------------------------------------------------
# IAM Policy
#------------------------------------------------------------------------------
output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = module.iam_role_lambda_support_api.policy_arn
}

output "policy_id" {
  description = "ID of the created IAM policy"
  value       = module.iam_role_lambda_support_api.policy_id
}

output "policy_name" {
  description = "Name of the created IAM policy"
  value       = module.iam_role_lambda_support_api.policy_name
}


#------------------------------------------------------------------------------
# IAM Role
#------------------------------------------------------------------------------
output "role_arn" {
  description = "ARN of the created IAM role"
  value       = module.iam_role_lambda_support_api.role_arn
}

output "role_id" {
  description = "ID of the created IAM role"
  value       = module.iam_role_lambda_support_api.role_id
}

output "role_name" {
  description = "Name of the created IAM role"
  value       = module.iam_role_lambda_support_api.role_name
}

output "role_unique_id" {
  description = "Unique ID of the IAM role"
  value       = module.iam_role_lambda_support_api.role_unique_id
}


#------------------------------------------------------------------------------
# CloudWatch Logs - Log Group
#------------------------------------------------------------------------------
output "log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = module.cloudwatch_logs_log_group.log_group_name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch Log Group"
  value       = module.cloudwatch_logs_log_group.log_group_arn
}

output "log_group_id" {
  description = "ID of the CloudWatch Log Group"
  value       = module.cloudwatch_logs_log_group.log_group_id
}

output "log_group_retention_in_days" {
  description = "Retention period in days"
  value       = module.cloudwatch_logs_log_group.retention_in_days
}

#------------------------------------------------------------------------------
# KMS Key
#------------------------------------------------------------------------------

output "kms_key_id" {
  description = "Id of the KMS Key"
  value       = module.kms_key_infra.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS Key"
  value       = module.kms_key_infra.key_arn
}

output "kms_key_alias_name" {
  description = "Alias Name of the KMS Key"
  value       = module.kms_key_infra.key_alias
}

output "kms_key_alias_arn" {
  description = "Alias ARN of the KMS Key"
  value       = module.kms_key_infra.key_alias_arn
}
