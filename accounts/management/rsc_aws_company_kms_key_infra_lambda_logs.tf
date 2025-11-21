#------------------------------------------------------------------------------
# Create a KMS Key to encrypt our CloudWatch Log Group used for our 
# Infrastructure Common Lambda Function Logs
#------------------------------------------------------------------------------
module "kms_key_infra" {
  # GENERAL
  source                            = "git@github.com:christophefund/opentofu_aws_modules.git//kms/key"
  
  tags = merge(
    var.tags, {
      Product = "LandingZone",
      Tenant  = "Common",
      Name    = "infra-lambda-logs-key"
    }
  )

  # KMS KEY
  key_description                   = "Encryption key for Common Infrastructure Lambda Function logs"
  key_alias                         = "infra-lambda-logs-key"
  enable_key_rotation               = true
  deletion_window_in_days           = 30
  
  key_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableRootUserPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:root",
          AWS = "arn:aws:iam::${local.account_id}:user/cloud_user"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowCloudWatchLogsForLambda"
        Effect = "Allow"
        Principal = {
          Service = "logs.amazonaws.com"  # Doesn't specify an AWS Region, allows CloudWatch to use this key from all regions
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:CreateGrant",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          ArnLike = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:*:${local.account_id}:log-group:/aws/lambda/infra/*" # Doesn't specify an AWS Region, allows CloudWatch to use this key from all regions for any Lamdba function running in any region
          }
        }
      }
    ]
  })
}