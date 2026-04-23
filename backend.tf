terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-777"
    key            = "devops/ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}