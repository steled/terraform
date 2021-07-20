resource "kubernetes_persistent_volume" "glusterfs_persistent_volume" {
  metadata {
    name = var.glusterfs_persistent_volume_name
  }

  spec {
    capacity = {
      storage = var.glusterfs_persistent_volume_capacity
    }
    access_modes = var.glusterfs_persistent_volume_access_mode
    persistent_volume_source {
      glusterfs {
        endpoints_name = var.glusterfs_endpoints_name
        path           = var.glusterfs_persistent_volume_path
        read_only      = var.glusterfs_persistent_volume_rad_only
      }
    }
  }
}