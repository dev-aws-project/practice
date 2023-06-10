terraform {
  backend "s3" {
    bucket         = "yury-aws-project-remote-state"
    key            = "aws-project/terraform/live/dev/rds-dev.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"

  }
}



