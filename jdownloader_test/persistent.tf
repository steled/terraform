resource "kubernetes_persistent_volume" "jd-sftp-test-config-pv" {
  metadata {
    name = var.config_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp-test"
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
        path = "/ext/persistent/jdownloader-test/config"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp-test, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-test-config-pvc" {
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
    volume_name = kubernetes_persistent_volume.jd-sftp-test-config-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-test-config-pv, ]
}

resource "kubernetes_persistent_volume" "jd-sftp-test-downloads-pv" {
  metadata {
    name = var.downloads_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp-test"
    }
  }
  spec {
    storage_class_name = "manual"
    capacity = {
      storage = "5Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/jdownloader-test/downloads"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp-test, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-test-downloads-pvc" {
  metadata {
    name = var.downloads_pvc_name
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.jd-sftp-test-downloads-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-test-downloads-pv, ]
}

resource "kubernetes_persistent_volume" "jd-sftp-test-logs-pv" {
  metadata {
    name = var.logs_pv_name
#    annotations = {
#      "pv.beta.kubernetes.io/gid" = "3000"
#    }
    labels = {
      type = "local"
      app  = "jd-sftp-test"
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
        path = "/ext/persistent/jdownloader-test/logs"
      }
    }
  }

  depends_on = [ kubernetes_namespace.jd-sftp-test, ]
}

resource "kubernetes_persistent_volume_claim" "jd-sftp-test-logs-pvc" {
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
    volume_name = kubernetes_persistent_volume.jd-sftp-test-logs-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.jd-sftp-test-logs-pv, ]
}