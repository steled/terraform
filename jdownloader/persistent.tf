resource "kubernetes_persistent_volume" "jd-sftp-config-pv" {
  metadata {
    name = var.config_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "100Mi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/jdownloader/config"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-config-pvc" {
  metadata {
    name = var.config_pvc_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Mi"
      }
    }
    volume_name = kubernetes_persistent_volume.jd-sftp-config-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-config-pv, ]
}

resource "kubernetes_persistent_volume" "jd-sftp-downloads-pv" {
  metadata {
    name = var.downloads_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "50Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/jdownloader/downloads"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-downloads-pvc" {
  metadata {
    name = var.downloads_pvc_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "50Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.jd-sftp-downloads-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-downloads-pv, ]
}

resource "kubernetes_persistent_volume" "jd-sftp-logs-pv" {
  metadata {
    name = var.logs_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "100Mi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/jdownloader/logs"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-logs-pvc" {
  metadata {
    name = var.logs_pvc_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Mi"
      }
    }
    volume_name = kubernetes_persistent_volume.jd-sftp-logs-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-logs-pv, ]
}