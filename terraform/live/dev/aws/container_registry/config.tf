terraform {
  backend "s3" {
    bucket         = "yury-aws-project-remote-state"
    key            = "aws-project/terraform/live/dev/container-registry.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"

  }
}

terraform {
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

}