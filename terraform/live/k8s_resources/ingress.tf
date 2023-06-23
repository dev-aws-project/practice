resource "kubernetes_ingress" "ladder_ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "ladder-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = "svc-frontend"
            service_port = 80
          }
        }
        path {
          path = "/*"
          backend {
            service_name = "svc-backend"
            service_port = 8080
          }
        }
        path {
          path = "/*"
          backend {
            service_name = "svc-notif"
            service_port = 8081
          }
        }
      }
    }
  }
}
