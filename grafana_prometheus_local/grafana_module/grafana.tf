resource "helm_release" "grafana" {
  name       = var.helm_release_name

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.6.2"

  values = [ file("${path.module}/values.yaml") ]

  namespace = var.kubernetes_namespace_name
}