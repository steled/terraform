resource "kubernetes_persistent_volume" "prometheus-server-pv" {
  metadata {
    name = "prometheus-server-pv"
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
        path = "/ext/persistent/prometheus/server"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "prometheus-server-pvc" {
  metadata {
    name = "prometheus-server-pvc"
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
    volume_name = kubernetes_persistent_volume.prometheus-server-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.prometheus-server-pv, ]
}

resource "kubernetes_persistent_volume" "prometheus-alertmanager-pv" {
  metadata {
    name = "prometheus-alertmanager-pv"
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
        path = "/ext/persistent/prometheus/alertmanager"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "prometheus-alertmanager-pvc" {
  metadata {
    name = "prometheus-alertmanager-pvc"
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
    volume_name = kubernetes_persistent_volume.prometheus-alertmanager-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.prometheus-alertmanager-pv, ]
}