terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "yurymarketma"

    workspaces {
      name = "practice"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"

    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #   access_key = var.access_key_aws_practice
  #   secret_key = var.secret_key_aws_practice
}
