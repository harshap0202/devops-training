# Day 29 Task

 - **Project Objective:**
This project will test your skills in using Terraform modules, functions, variables, state locks, and remote state management. The project requires deploying infrastructure on AWS using a custom Terraform module and managing the state remotely in an S3 bucket, while testing the locking mechanism with DynamoDB. Participants will also configure variables and outputs using functions.

 - **Project Overview:**
You will create a Terraform configuration that uses a custom module to deploy a multi-component infrastructure on AWS. The state files will be stored remotely in an S3 bucket, and DynamoDB will handle state locking. Additionally, the project will involve creating a flexible and reusable Terraform module, using input variables (tfvars) and Terraform functions to parameterize configurations.

## Key Tasks:

### S3 Bucket for State:
Create an S3 bucket using Terraform.
```hcl
resource "aws_s3_bucket" "terraform_state" {
  bucket = "harsh-terraform-state-bucket"

  tags = {
    Name = "Harshwardhan Terraform State Bucket"
  }
}
```

### State Locking with DynamoDB:
Create a DynamoDB table using Terraform to store the state lock information.
```hcl
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "harsh-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
```

## Final Outputs

 - terraform initialized
![alt text](<img/Screenshot from 2024-08-21 17-36-50.png>)

 - terraform format check
![alt text](<img/Screenshot from 2024-08-21 17-37-07.png>) 

 - terrafrom plan and apply
![alt text](<img/Screenshot from 2024-08-21 17-37-33.png>) 
![alt text](<img/Screenshot from 2024-08-21 17-37-36.png>)

 - Configure Terraform to store the state file in the S3 bucket.
 - Configure Terraform to use this DynamoDB table for state locking.

![alt text](<img/Screenshot from 2024-08-21 21-49-52.png>)

### Custom Module:
Create a Terraform module to deploy the following AWS resources:
EC2 instance: Use an AMI for the region and allow SSH access using a security group.
S3 bucket: Create an S3 bucket for application data.

### Terraform Functions:
Use Terraform functions in your module to manipulate and process the variables. For example:
 - Use join to combine strings for resource names.

![alt text](<img/Screenshot from 2024-08-21 21-46-25.png>)

### Input Variables and Configuration (tfvars):
Define input variables to make the infrastructure flexible:
 - EC2 instance type.
 - S3 bucket name.
 - AWS region.

![alt text](<img/Screenshot from 2024-08-21 21-44-40.png>)

### Output Configuration:
Set up Terraform outputs to display key information after the infrastructure is created:
EC2 Public IP: Output the public IP of the EC2 instance.
S3 Bucket Name: Output the name of the S3 bucket created.

![alt text](<img/Screenshot from 2024-08-21 21-35-15.png>)

### State Locking:
Attempt to run terraform apply from two different terminals simultaneously to test state locking.
Confirm that DynamoDB properly handles the state lock, preventing concurrent updates.

![alt text](<img/Screenshot from 2024-08-21 21-28-43.png>)

### Remote State Management:
Verify that Terraform state is being stored in the S3 bucket and that updates are reflected in the remote state file.
Apply and Modify Infrastructure:

![alt text](<img/Screenshot from 2024-08-21 21-19-24.png>)

### Initial Deployment:
Use terraform plan and terraform apply to deploy the infrastructure.
Verify that the EC2 instance, S3 bucket, and all configurations are properly set up.

ec2 Instance created
![alt text](<img/Screenshot from 2024-08-21 21-22-18.png>)

S3 Bucket created
![alt text](<img/Screenshot from 2024-08-21 21-20-14.png>) 

### Infrastructure Changes:
Modify one of the variables (e.g., change the instance type or add tags) and re-run terraform apply.
Observe how Terraform plans and applies only the necessary changes, with state locking in effect.
![alt text](<img/Screenshot from 2024-08-21 21-27-10.png>)
![alt text](<img/Screenshot from 2024-08-21 21-26-19.png>)

### Resource Termination:
Once the deployment is complete and tested, use terraform destroy to tear down all the resources created by Terraform.

**S3 bucket and ec2 instance deleted**
![alt text](<img/Screenshot from 2024-08-21 21-52-44.png>) 
![alt text](<img/Screenshot from 2024-08-21 21-52-58.png>) 

**s3 bucket and dynamodb table deleted**
![alt text](<img/Screenshot from 2024-08-21 21-55-17.png>) 
![alt text](<img/Screenshot from 2024-08-21 21-55-19.png>)