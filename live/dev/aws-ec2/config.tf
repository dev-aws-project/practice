terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "yurymarketma"

    workspaces {
      name = "practice"
    }
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
