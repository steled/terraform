resource "kubernetes_persistent_volume" "nextcloud-server-pv" {
  metadata {
    name = "nextcloud-staging-server-pv"
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
        path = "/ext/persistent/nextcloud_staging/server"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-server-pvc" {
  metadata {
    name = "nextcloud-staging-server-pvc"
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
    name = "nextcloud-staging-postgresql-pv"
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
        path = "/ext/persistent/nextcloud_staging/postgresql"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-postgresql-pvc" {
  metadata {
    name = "nextcloud-staging-postgresql-pvc"
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
    name = "nextcloud-staging-backup-pv"
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
        path = "/ext/persistent/nextcloud_staging/backup"
      }
    }
  }

  depends_on = [ kubernetes_namespace.nextcloud, ]
}

resource "kubernetes_persistent_volume_claim" "nextcloud-backup-pvc" {
  metadata {
    name = "nextcloud-staging-backup-pvc"
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