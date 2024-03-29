

resource "helm_release" "nginx-ingress-controller" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"


  # set {
  #   name  = "service.type"
  #   value = "LoadBalancer"
  # }

}

resource "kubernetes_ingress_v1" "frontend_ingress" {
  metadata {
    name = "frontend-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "ladder.prtest.be"
      http {
        path {
          backend {
            service {
              name = "svc-frontend"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
  depends_on = [helm_release.nginx-ingress-controller]
}

resource "kubernetes_ingress_v1" "backend_ingress" {
  metadata {
    name = "backend-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "ladder.prtest.be"
      http {
        path {
          backend {
            service {
              name = "svc-backend"
              port {
                number = 8080
              }
            }
          }
          path = "/backend"
        }
      }
    }
  }
  depends_on = [helm_release.nginx-ingress-controller]
}

resource "kubernetes_ingress_v1" "notif_ingress" {
  metadata {
    name = "notif-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "ladder.prtest.be"
      http {
        path {
          backend {
            service {
              name = "svc-notif"
              port {
                number = 8081
              }
            }
          }
          path = "/notif"
        }
      }
    }
  }

  depends_on = [helm_release.nginx-ingress-controller]
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
