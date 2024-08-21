To tackle this advanced Terraform project, you will need to follow a structured approach that includes setting up remote state management, creating a reusable module, parameterizing configurations, and testing state locking. Here's a step-by-step guide to help you achieve each key task:

### 1. Remote State Management

#### **S3 Bucket for State**
1. **Create an S3 Bucket for Terraform State**:
   Create a new Terraform configuration file to set up the S3 bucket. This bucket will be used to store the Terraform state file.

   ```hcl
   # s3_bucket.tf
   provider "aws" {
     region = "us-east-1" # Change to your preferred region
   }

   resource "aws_s3_bucket" "terraform_state" {
     bucket = "my-terraform-state-bucket"
     acl    = "private"
   }

   resource "aws_s3_bucket_versioning" "versioning" {
     bucket = aws_s3_bucket.terraform_state.id
     versioning_configuration {
       status = "Enabled"
     }
   }
   ```

2. **Configure Terraform to Use the S3 Bucket for State**:
   In your Terraform configuration, configure the backend to use the S3 bucket for state storage.

   ```hcl
   # backend.tf
   terraform {
     backend "s3" {
       bucket         = "my-terraform-state-bucket"
       key            = "terraform/state"
       region         = "us-east-1"
     }
   }
   ```

   Initialize Terraform to configure the backend:

   ```sh
   terraform init
   ```

#### **State Locking with DynamoDB**
1. **Create a DynamoDB Table for State Locking**:
   Create a DynamoDB table to handle state locking. This can be included in the same Terraform configuration or created separately.

   ```hcl
   # dynamodb.tf
   resource "aws_dynamodb_table" "terraform_locks" {
     name         = "terraform-locks"
     hash_key     = "LockID"
     read_capacity  = 1
     write_capacity = 1
     billing_mode = "PROVISIONED"
     
     attribute {
       name = "LockID"
       type = "S"
     }
   }
   ```

2. **Configure Terraform to Use DynamoDB for State Locking**:
   Update the backend configuration to include DynamoDB for state locking.

   ```hcl
   # backend.tf (updated)
   terraform {
     backend "s3" {
       bucket         = "my-terraform-state-bucket"
       key            = "terraform/state"
       region         = "us-east-1"
       dynamodb_table = "terraform-locks"
     }
   }
   ```

   Reinitialize Terraform to apply the updated backend configuration:

   ```sh
   terraform init
   ```

### 2. Terraform Module Creation

#### **Custom Module**
1. **Create a Directory for the Module**:
   Create a new directory for your Terraform module.

   ```sh
   mkdir -p modules/aws_resources
   ```

2. **Define the Module**:
   Inside `modules/aws_resources`, create `main.tf` to define the EC2 instance and S3 bucket resources.

   ```hcl
   # modules/aws_resources/main.tf
   variable "instance_type" {
     type    = string
     default = "t2.micro"
   }

   variable "region" {
     type    = string
     default = "us-east-1"
   }

   variable "bucket_name" {
     type    = string
     default = "my-app-bucket"
   }

   provider "aws" {
     region = var.region
   }

   resource "aws_instance" "web" {
     ami           = "ami-0c55b159cbfafe1f0" # Use an appropriate AMI for your region
     instance_type = var.instance_type

     tags = {
       Name = "MyInstance"
     }
   }

   resource "aws_s3_bucket" "app_bucket" {
     bucket = var.bucket_name
     acl    = "private"
   }
   ```

3. **Output the Information**:
   Define outputs to provide useful information after deployment.

   ```hcl
   # modules/aws_resources/outputs.tf
   output "instance_id" {
     value = aws_instance.web.id
   }

   output "instance_public_ip" {
     value = aws_instance.web.public_ip
   }

   output "bucket_name" {
     value = aws_s3_bucket.app_bucket.bucket
   }
   ```

#### **Root Module**
1. **Use the Module**:
   In your root Terraform configuration, use the module and provide necessary variables.

   ```hcl
   # main.tf
   module "aws_resources" {
     source       = "./modules/aws_resources"
     instance_type = "t2.micro"
     region        = "us-east-1"
     bucket_name   = "my-app-bucket"
   }

   output "instance_id" {
     value = module.aws_resources.instance_id
   }

   output "instance_public_ip" {
     value = module.aws_resources.instance_public_ip
   }

   output "bucket_name" {
     value = module.aws_resources.bucket_name
   }
   ```

### 3. Terraform Functions
1. **Use Functions in Your Module**:
   Implement functions such as `join`, `lookup`, and `length` in your module as needed. For example, using `join` to create a unique name.

   ```hcl
   # modules/aws_resources/main.tf (updated)
   resource "aws_s3_bucket" "app_bucket" {
     bucket = join("-", ["app-bucket", substr(md5(var.bucket_name), 0, 6)])
     acl    = "private"
   }
   ```

### 4. Testing State Locking and Remote State

#### **State Locking**
1. **Test State Locking**:
   Open two terminal sessions and try running `terraform apply` simultaneously in each. Confirm that only one can proceed and that the other is locked.

   ```sh
   terraform apply
   ```

   Check the DynamoDB table to verify that the state lock entry is created.

#### **Remote State Management**
1. **Verify Remote State**:
   After deployment, inspect the S3 bucket to ensure that the state file is present. Make changes to the infrastructure and verify that the state file updates accordingly.

### 5. Apply and Modify Infrastructure

#### **Initial Deployment**
1. **Deploy Infrastructure**:
   Run `terraform plan` to review the proposed changes and `terraform apply` to deploy.

   ```sh
   terraform plan
   terraform apply
   ```

   Confirm that the EC2 instance, S3 bucket, and all configurations are properly set up.

#### **Infrastructure Changes**
1. **Modify Variables**:
   Change one of the variables (e.g., instance type) in `terraform.tfvars`, then re-run `terraform apply`.

   ```hcl
   # terraform.tfvars
   instance_type = "t3.micro"
   ```

   Observe the changes and verify that only the necessary updates are applied.

#### **Resource Termination**
1. **Destroy Resources**:
   Run `terraform destroy` to remove all resources.

   ```sh
   terraform destroy
   ```

   Ensure that the S3 bucket, EC2 instance, and DynamoDB table (if not reused) are deleted.

This structured approach ensures that you effectively use Terraform modules, functions, and state management features, providing a robust and scalable infrastructure deployment.