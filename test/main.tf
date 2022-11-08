provider "kubernetes" {
  config_path = "/home/steled/.kube/config"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

module "glusterfs_endpoints_service" {
  source = "../glusterfs/endpoints_service"

  config_path = "/home/steled/.kube/config"
  kubernetes_namespace = "monitoring"
  glusterfs_endpoints_name = "prometheus-glusterfs-endpoints"
  glusterfs_endpoints_address = [ "172.100.17.11", "172.100.17.21", "172.100.17.22" ]
  glusterfs_endpoints_port = 1
  glusterfs_service_name = "prometheus-glusterfs-service"
  glusterfs_service_port = 1
}

module "glusterfs_pv_pvc" {
  source = "../glusterfs/pv_pvc"

  config_path = "/home/steled/.kube/config"
  kubernetes_namespace = "monitoring"

  for_each = var.gluster

  glusterfs_endpoints_name = "prometheus-glusterfs-endpoints"
  glusterfs_persistent_volume_name = each.value.glusterfs_persistent_volume_name
  glusterfs_persistent_volume_capacity = each.value.glusterfs_persistent_volume_capacity
  glusterfs_persistent_volume_access_mode = each.value.glusterfs_persistent_volume_access_mode
  glusterfs_persistent_volume_path = each.value.glusterfs_persistent_volume_path
  glusterfs_persistent_volume_rad_only = each.value.glusterfs_persistent_volume_rad_only
  glusterfs_persistent_volume_claim_name = each.value.glusterfs_persistent_volume_claim_name
  glusterfs_persistent_volume_claim_access_mode = each.value.glusterfs_persistent_volume_claim_access_mode
  glusterfs_persistent_volume_claim_capacity = each.value.glusterfs_persistent_volume_claim_capacity

}