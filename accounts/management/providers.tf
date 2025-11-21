#------------------------------------------------------------------------------
# Configure the Provider
#------------------------------------------------------------------------------
provider "aws" {
#  alias      = "home"
  region     = var.aws_home_region
/*
  assume_role {
    role_arn = "arn:aws:iam::111111111111:role/TerraformDeploymentRole"
    session_name = "terraform-session"
  }
*/
  access_key = var.aws_access_key # don't pass this information this way in Production env.
  secret_key = var.aws_secret_key # don't pass this information this way in Production env.
}