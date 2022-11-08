resource "kubernetes_secret" "grafana-secret" {
  metadata {
    name      = "grafana-secret"
    namespace = var.kubernetes_namespace_name
  }

  data = {
    admin-user     = "admin"
    admin-password = var.admin_password
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "grafana-datasources" {
  metadata {
    name      = "grafana-datasources"
    namespace = var.kubernetes_namespace_name
    labels    = {
      grafana_datasource = "prometheus"
    }
  }

  data = {
    "datasources.yaml" = "${file("${path.module}/datasources.yml")}"
  }
}

resource "helm_release" "grafana" {
  name       = var.helm_release_name

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.38.6" # check version here: https://github.com/grafana/helm-charts/blob/main/charts/grafana/Chart.yaml

#  values     = [ file("${path.module}/values.yaml") ]
  values = [ templatefile("${path.module}/values.yaml", {
    namespace = var.kubernetes_namespace_name,
    environment = var.environment,
    domain = var.domain
  }) ]

  namespace  = var.kubernetes_namespace_name
}