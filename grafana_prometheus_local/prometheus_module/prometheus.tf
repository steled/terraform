resource "helm_release" "prometheus" {
  name       = var.helm_release_name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "13.6.0"

  values = [ file("${path.module}/values.yaml") ]

  namespace = var.kubernetes_namespace_name
}