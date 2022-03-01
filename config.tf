provider "aws" {
  region  = var.region
  version = ">= 3.0"
}

terraform {
  backend "s3" {
    bucket = "serverlessapplicationstatefile"
    key    = "terraform.tfstate" 
    region = "us-east-1"
  }

  required_version = ">= 0.12"
}