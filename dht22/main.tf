provider "kubernetes" {
  config_path = var.config_path
}

resource "kubernetes_namespace" "sdm-dht22" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

module "sdm" {
  source = "./sdm"
  kubernetes_namespace_name = var.kubernetes_namespace_name
  node_name                 = var.node_name
  image                     = var.sdm_image # check version here: https://gitlab.com/arm-research/smarter/smarter-device-manager/container_registry/1080664
}

module "dht22" {
  source = "./dht22"

  kubernetes_namespace_name = var.kubernetes_namespace_name
  node_name                 = var.node_name
  image                     = var.dht22_image

  depends_on = [ module.sdm, ]
}
