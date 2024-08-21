terraform {
  backend "s3" {
    bucket         = "harsh-terraform-state-bucket" 
    key            = "terraform/state.tfstate"
    region         = "us-east-2" 
    encrypt        = true
    dynamodb_table = "harsh-terraform-locks" 
  }
}
