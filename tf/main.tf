# Specify the required provider and version
terraform {
  backend "s3" {
    bucket         = "quest-challenge-tfstate"
    key            = "terraform.tfstate"
    encrypt        = true
  }
  required_providers {
    aws = {
      source       = "hashicorp/aws"
      version      = "~> 4.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}