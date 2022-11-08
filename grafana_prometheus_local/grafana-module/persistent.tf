resource "kubernetes_persistent_volume" "grafana-pv" {
  metadata {
    name = "grafana-pv"
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/grafana"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "grafana-pvc" {
  metadata {
    name = "grafana-pvc"
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.grafana-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.grafana-pv, ]
}