data "terraform_remote_state" "ingress_controller" {
  backend = "s3"

  config = {
    bucket = "yury-aws-project-remote-state"
    key    = "aws-project/terraform/live/dev/k8s_resources.tfstate"
    region = "us-east-1"
  }
}

resource "aws_route53_record" "www" {
  zone_id = "Z07606132J83HBCKKYO55"
  name    = "ladder"
  type    = "CNAME"
  ttl     = 300
  records = [data.terraform_remote_state.ingress_controller.outputs.k8s_service_ingress_elb]
}



