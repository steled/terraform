resource "kubernetes_service" "hassio" {
  metadata {
    name      = var.metadata_name
    namespace = kubernetes_namespace.hassio.metadata[0].name
  }
  spec {
    port {
      name        = var.port_name
      port        = 443
      target_port = 8123
      protocol    = "TCP"
    }
  }
}