resource "kubernetes_service" "svc_frontend" {
  metadata {
    name = "svc-frontend"
  }
  spec {
    selector = {
      project : "frontend"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "svc_backend" {
  metadata {
    name = "svc-backend"
  }
  spec {
    selector = {
      project : "backend"
    }
    port {
      port        = 8080
      target_port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service" "svc_notif" {
  metadata {
    name = "svc-notif"
  }
  spec {
    selector = {
      project : "notif"
    }
    port {
      port        = 8081
      target_port = 8081
    }
    type = "ClusterIP"
  }
}
