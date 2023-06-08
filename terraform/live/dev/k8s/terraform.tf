# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  backend "s3" {
    bucket         = "yury-aws-project-remote-state"
    key            = "aws-project/terraform/live/dev/eks-cluster.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"

  }
}


terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.59.0"

    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.3"
}



