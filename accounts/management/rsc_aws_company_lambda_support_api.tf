#------------------------------------------------------------------------------
# Create a CloudWatch Log Group for our Lambda function Logs
#------------------------------------------------------------------------------
module "cloudwatch_logs_log_group" {
  # GENERAL
  source              = "git@github.com:christophefund/opentofu_aws_modules.git//cloudwatch/logs/log_group"             # refers to the last commited version on the default branch
  /*providers = {
    aws = aws.home_region
  }*/
  tags                = var.tags

  log_group_name    = "/aws/lambda/controltower-account-support-enrollment"
  retention_in_days = 365
  kms_key_arn       = module.kms_key_infra.key_alias_arn
}


#------------------------------------------------------------------------------
# Create an IAM Role for Lambda in charge of
# opening Support Ticket to add Support to newly created AWS Accounts
#------------------------------------------------------------------------------
module "iam_role_lambda_support_api" {
  # GENERAL
  source              = "git@github.com:christophefund/opentofu_aws_modules.git//iam/iam_role"             # refers to the last commited version on the default branch
  /*providers = {
    aws = aws.home_region
  }*/
  tags                = var.tags

  # POLICY
  policy_name        = "lambda-support-api-readwrite-policy"
  policy_description = "Allows Lambda functions to read/write to AWS Support API"
  
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${local.region}:${local.account_id}:log-group:${module.cloudwatch_logs_log_group.log_group_id}:*"
      },
      {
        Effect = "Allow"
        Action = [
          "support:CreateCase",
          "support:DescribeCases",
          "support:AddCommunicationToCase"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "organizations:DescribeAccount",
          "organizations:ListAccounts"
        ]
        Resource = "*"
      }
    ]
  })

  # ROLE
  role_name        = "lambda-support-api-readwrite-role"
  role_description = "Role for Lambda functions to read/write to AWS Support API"
  
  trust_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
/*
  additional_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
*/
}


#------------------------------------------------------------------------------
# Create a Lambda function to open an AWS Support Ticket every time a new AWS
# Account is created in order to enrol it with AWS Support
#------------------------------------------------------------------------------
module "lambda_support_api" {
  # GENERAL
  source        = "git@github.com:christophefund/opentofu_aws_modules.git//lambda/function"             # refers to the last commited version on the default branch
  tags          = var.tags

  # LAMBDA FUNCTION
  function_name = "infra-enroll-new-account-w-support"            
  handler       = "infra-enroll-new-account-w-support.create_case"                                      # file_name.function_name in the root directory of the package
  runtime       = "python3.13"
  filename      = "${path.module}/../../../../lambda_pkg/infra-enroll-new-account-w-support.zip"

  iam_role      = module.iam_role_lambda_support_api.role_arn

/*
  environment_vars = {
    ENV = "prod"
  }
  */
}
