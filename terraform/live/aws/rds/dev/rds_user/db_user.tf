terraform {
  required_version = ">= 1.0.4"
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.19.0"
    }
  }
}

# provider "postgresql" {
#   #alias = "pgadm"
#   #scheme           = "postgres"
#   host             = var.dbhost
#   port             = var.dbport
#   username         = var.pgadmin_user
#   password         = var.password
#   sslmode          = var.sslmode
#   connect_timeout  = var.connect_timeout
#   superuser        = var.superuser
#   expected_version = var.expected_version
# }

provider "postgresql" {
  #alias = "pgmgm"
  scheme = "awspostgres"
  host   = var.dbhost
  port   = var.dbport
  #database        = "postgres"
  username        = var.pgadmin_user
  password        = var.password
  sslmode         = var.sslmode
  connect_timeout = var.connect_timeout
  superuser       = var.superuser
  # aws_rds_iam_auth    = true
  # aws_rds_iam_profile = "terraform"
  # aws_rds_iam_region  = "us-east-1"
  #expected_version = var.expected_version
}

resource "postgresql_role" "app_users" {
  for_each = { for tuple in var.db_users : tuple.name => tuple }

  name  = "backend"
  login = true
  #roles               = ["pg_signal_backend"]
  inherit             = true
  valid_until         = "infinity"
  encrypted_password  = true
  password            = "backend"
  skip_drop_role      = false
  skip_reassign_owned = false
  create_role         = false
  connection_limit    = -1
  search_path         = null
}





