variable "s3_name" {
  type = string
}

variable "dynamodb_name" {
  type    = string
  default = "terraform-state-lock"
}

