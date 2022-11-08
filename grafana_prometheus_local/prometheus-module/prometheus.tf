resource "helm_release" "prometheus" {
  name       = var.helm_release_name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "15.13.0" # check version here: https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/Chart.yaml

  values = [ file("${path.module}/values.yaml") ]

  namespace = var.kubernetes_namespace_name
}