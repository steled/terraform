resource "kubernetes_persistent_volume" "nextcloud-server-pv" {
  metadata {
    name = "nextcloud-server-pv"
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
      storage = "8Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/nextcloud/server"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-server-pvc" {
  metadata {
    name = "nextcloud-server-pvc"
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
    volume_name = kubernetes_persistent_volume.nextcloud-server-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.nextcloud-server-pv, ]
}

resource "kubernetes_persistent_volume" "nextcloud-postgresql-pv" {
  metadata {
    name = "nextcloud-postgresql-pv"
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
      storage = "8Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/nextcloud/postgresql"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-postgresql-pvc" {
  metadata {
    name = "nextcloud-postgresql-pvc"
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
    volume_name = kubernetes_persistent_volume.nextcloud-postgresql-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.nextcloud-postgresql-pv, ]
}

resource "kubernetes_persistent_volume" "nextcloud-backup-pv" {
  metadata {
    name = "nextcloud-backup-pv"
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
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/ext/persistent/nextcloud/backup"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-backup-pvc" {
  metadata {
    name = "nextcloud-backup-pvc"
    namespace = var.kubernetes_namespace_name
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.nextcloud-backup-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.nextcloud-backup-pv, ]
}