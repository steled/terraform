provider "kubernetes" {
  config_path = var.config_path
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

module "grafana" {
  source = "./grafana_module"

  helm_release_name = var.grafana_helm_release_name
  kubernetes_namespace_name = var.kubernetes_namespace_name

  depends_on = [ kubernetes_namespace.monitoring ]
}

module "prometheus" {
  source = "./prometheus_module"

  helm_release_name = var.prometheus_helm_release_name
  kubernetes_namespace_name = var.kubernetes_namespace_name

  depends_on = [ kubernetes_namespace.monitoring ]
}