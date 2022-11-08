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

module "prometheus" {
  source = "./prometheus-module"

  helm_release_name = var.prometheus_helm_release_name
  kubernetes_namespace_name = var.kubernetes_namespace_name

  depends_on = [ kubernetes_namespace.monitoring ]
}

module "grafana" {
  source = "./grafana-module"

  helm_release_name         = var.grafana_helm_release_name
  kubernetes_namespace_name = var.kubernetes_namespace_name
  admin_password            = var.grafana_admin_password
  environment               = var.grafana_environment
  domain                    = var.grafana_domain

  depends_on = [ kubernetes_namespace.monitoring, module.prometheus ]
}
