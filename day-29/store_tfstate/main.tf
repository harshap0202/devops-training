provider "aws" {
  region = "us-east-2"
  profile = "devops-training"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "harsh-terraform-state-bucket"

  tags = {
    Name = "Harshwardhan Terraform State Bucket"
  }
}


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

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

