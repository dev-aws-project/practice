module "remote_state_s3" {
  source = "../../../modules/s3_backend"
  #region        = "us-east-1"
  s3_name       = "yury-aws-project-remote-state"
  dynamodb_name = "terraform-state-lock"

}
