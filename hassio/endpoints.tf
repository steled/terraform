resource "kubernetes_endpoints" "hassio" {
  metadata {
    name = var.metadata_name
    namespace = kubernetes_namespace.hassio.metadata[0].name
  }

  subset {
    address {
      ip = "172.16.3.20"
    }

    port {
      name     = var.port_name
      port     = 8123
      protocol = "TCP"
    }
  }
}