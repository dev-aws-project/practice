# module "cert_manager" {
#   source = "terraform-iaac/cert-manager/kubernetes"

#   cluster_issuer_email                   = "admin@mysite.com"
#   cluster_issuer_name                    = "cert-manager-global"
#   cluster_issuer_private_key_secret_name = "cert-manager-private-key"
#   certificates = {
#     "my-certificate" = {
#       dns_names = ["atlantis.prtest.tech"]
#     }
#   }
# }
