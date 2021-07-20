resource "kubernetes_endpoints" "glusterfs_endpoints" {
  metadata {
    name      = var.glusterfs_endpoints_name
    namespace = var.kubernetes_namespace_name
  }
  subset {
    dynamic "address" {
      for_each = var.glusterfs_endpoints_address

      content {
        ip = address.value
      }
    }
    port {
      port = var.glusterfs_endpoints_port
    }
  }
}