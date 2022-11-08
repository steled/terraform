provider "kubernetes" {
  config_path = var.config_path
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}

module "glusterfs_endpoints_service" {
  source = "../glusterfs/endpoints_service"

  config_path = var.config_path
  kubernetes_namespace = var.kubernetes_namespace_name
  glusterfs_endpoints_name = var.glusterfs_endpoints_name
  glusterfs_endpoints_address = var.glusterfs_endpoints_address
  glusterfs_endpoints_port = var.glusterfs_endpoints_port
  glusterfs_service_name = var.glusterfs_service_name
  glusterfs_service_port = var.glusterfs_service_port
}

module "glusterfs_pv_pvc" {
  source = "../glusterfs/pv_pvc"

  config_path = var.config_path
  kubernetes_namespace = var.kubernetes_namespace_name

  for_each = var.gluster

  glusterfs_endpoints_name = var.glusterfs_endpoints_name
  glusterfs_persistent_volume_name = each.value.glusterfs_persistent_volume_name
  glusterfs_persistent_volume_capacity = each.value.glusterfs_persistent_volume_capacity
  glusterfs_persistent_volume_access_mode = each.value.glusterfs_persistent_volume_access_mode
  glusterfs_persistent_volume_path = each.value.glusterfs_persistent_volume_path
  glusterfs_persistent_volume_rad_only = each.value.glusterfs_persistent_volume_rad_only
  glusterfs_persistent_volume_claim_name = each.value.glusterfs_persistent_volume_claim_name
  glusterfs_persistent_volume_claim_access_mode = each.value.glusterfs_persistent_volume_claim_access_mode
  glusterfs_persistent_volume_claim_capacity = each.value.glusterfs_persistent_volume_claim_capacity

}