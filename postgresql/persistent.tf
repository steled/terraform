resource "kubernetes_persistent_volume" "postgresql-pv" {
  metadata {
    name = "postgresql-pv"
    labels = {
      type = "local"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "8Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/postgresql"
      }
    }
  }

  depends_on = [ kubernetes_namespace.postgresql, ]
}

resource "kubernetes_persistent_volume_claim" "postgresql-pvc" {
  metadata {
    name = "postgresql-pvc"
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "8Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.postgresql-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.postgresql-pv, ]
}
