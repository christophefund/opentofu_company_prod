# terraform-democompany-prod

Simulation of the Infrastructure setup for a demo company.

The Terraform State file is to be stored on a Backend Previously created in a Central Terraform AWS Account.


# Install the AWS CLI on Linux
```bash
# Download the correct AWS CLI installer for your machine
# ARM64 
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
# x86_64
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer script
sudo ./aws/install

# Verify installation
aws --version

# Cleanup installation files
rm -rf awscliv2.zip aws
```


# Create an AWS SDK Profile
```bash
aws configure --profile terraform-profile

# This creates or updates the profile in  ~/.aws/credentials  and  ~/.aws/config
```

# Define the environment variable AWS_PROFILE
```bash
set AWS_PROFILE=terraform-profile
```

# In order to store the Terraform State file on S3
### 1. Create a bucket for it, preferably encrypted with a KMS Key
### 2. Update the providers.tf file
### 3. Uncomment the "backend" block and update it appropriately
```terraform
  backend "s3" {
    bucket         = "company-prod-s3-tfstate-bae2"            # INSERT BUCKET NAME
    key            = "terraform/terraform.tfstate"             # UPDATE PATH IF NECESSARY
    region         = "us-east-1"                               # INSERT THE APPROPRIATE REGION
    encrypt        = true                                      # IF THE BUCKET POLICY ENFORCES ENCRYPTION AT REST, THIS IS MANDATORY TO BE SET TO TRUE
    kms_key_id     = "alias/s3-terraform"                      # SET HERE THE ALIAS OF THE KMS KEY USED FOR THE BUCKET
    profile        = "terraform-profile"                       # SPECIFY YOUR AWS PROFILE IN ORDER TO CONNECT TO THE BACKEND USING YOUR PROFILE CREDENTIALS
    use_lockfile   = true                                      # S3 NATIVE STATE LOCKING

    assume_role = {
      role_arn = "arn:aws:iam::<CENTRAL_TERRAFORM_AWS_ACCOUNT>:role/s3-terraform-state-access"  # ARN OF THE ROLE TO BE USED TO ACCESS THE S3 BUCKET IN THE CENTRAL TERRAFORM S3 BUCKET
      session_name = "terraform"
    }
  }
```

### 4. Initialize again your terraform repository
```terraform
terraform init

# This should prompt you to upload your current state file to S3
```