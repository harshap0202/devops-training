variable "profile" {
    default = "devops-training"
}     

variable "ami_id" {
    default = "ami-0e86e20dae9224db8"
}          

variable "instance_type" {
    default = "t2.micro"
}   

variable "region" {
    default = "us-east-1"
}          

variable "instance_name" {
    default = "new-instance"
}   

variable "private_key_path" {
    default = "~/Downloads/harsh-key.pem"
} 

variable "bucket_name" {
    default = "s3-bucket-terraform-111"
}     

