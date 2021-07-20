provider "kubernetes" {
  config_path = var.config_path
}

resource "kubernetes_namespace" "hassio" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}