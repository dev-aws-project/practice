resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "42.0.0"
  create_namespace = true
  namespace        = "prometheus"

  values = [
    "${file("values/prometheus.yaml")}"
  ]
}
