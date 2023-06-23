

resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"


  # set {
  #   name  = "service.type"
  #   value = "LoadBalancer"
  # }

}

data "kubernetes_service" "ingress_nginx" {

  metadata {
    name      = "nginx-ingress-controller"
    namespace = "default"
  }
  depends_on = [
    helm_release.nginx-ingress-controller
  ]
}

output "k8s_service_ingress_elb" {
  description = "External DN name of elastic load balancer"
  value       = data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.hostname

}
