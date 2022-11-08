resource "kubernetes_persistent_volume_claim" "glusterfs_persistent_volume_claim" {
  metadata {
    name      = var.glusterfs_persistent_volume_claim_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    access_modes = var.glusterfs_persistent_volume_claim_access_mode
    resources {
      requests = {
        storage = var.glusterfs_persistent_volume_claim_capacity
      }
    }
    volume_name = kubernetes_persistent_volume.glusterfs_persistent_volume.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.glusterfs_persistent_volume, ]
}