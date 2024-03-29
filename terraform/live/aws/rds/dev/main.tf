module "rds" {
  source = "../../../../modules/aws/rds"

  create_db_subnet_group          = true
  db_subnet_group_name            = "rds-dev"
  db_subnet_group_use_name_prefix = false
  db_subnet_group_description     = "Subnet group for RDS dev"
  subnet_ids                      = [data.terraform_remote_state.vpc.outputs.subnet_kuber_1a_id, data.terraform_remote_state.vpc.outputs.subnet_kuber_1b_id]


  create_db_parameter_group = false

  create_db_option_group = false

  create_db_instance             = true
  identifier                     = "ladder"
  instance_use_identifier_prefix = false

  engine            = "postgres"
  engine_version    = "13.11"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"
  storage_encrypted = true

  db_name                = "ladder"
  username               = "dbmainuser"
  password               = "dbmainuser"
  port                   = "5432"
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_allow_tls_id]


  publicly_accessible = true
  apply_immediately   = true


  skip_final_snapshot = true

  delete_automated_backups = true

}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "yury-aws-project-remote-state"
    key    = "aws-project/terraform/live/dev/vpc.tfstate"
    region = "us-east-1"
  }
}

