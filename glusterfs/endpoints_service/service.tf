resource "kubernetes_service" "glusterfs_service" {
  metadata {
    name = var.glusterfs_service_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    port {
      port = var.glusterfs_service_port
    }
  }

  depends_on = [ kubernetes_endpoints.glusterfs_endpoints, ]
}