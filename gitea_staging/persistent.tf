resource "kubernetes_persistent_volume" "gitea_staging-server-pv" {
  metadata {
    name = "gitea-staging-server-pv"
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
        path = "/ext/persistent/gitea_staging/server"
      }
    }
  }

  depends_on = [ kubernetes_namespace.gitea_staging, ]
}

resource "kubernetes_persistent_volume_claim" "gitea_staging-server-pvc" {
  metadata {
    name = "gitea-staging-server-pvc"
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
    volume_name = kubernetes_persistent_volume.gitea_staging-server-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.gitea_staging-server-pv, ]
}

resource "kubernetes_persistent_volume" "gitea_staging-postgresql-pv" {
  metadata {
    name = "gitea-staging-postgresql-pv"
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
        path = "/ext/persistent/gitea_staging/postgresql"
      }
    }
  }

  depends_on = [ kubernetes_namespace.gitea_staging, ]
}

resource "kubernetes_persistent_volume_claim" "gitea_staging-postgresql-pvc" {
  metadata {
    name = "gitea-staging-postgresql-pvc"
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
    volume_name = kubernetes_persistent_volume.gitea_staging-postgresql-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.gitea_staging-postgresql-pv, ]
}

resource "kubernetes_persistent_volume" "gitea_staging-backup-pv" {
  metadata {
    name = "gitea-staging-backup-pv"
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
        path = "/ext/persistent/gitea_staging/backup"
      }
    }
  }

  depends_on = [ kubernetes_namespace.gitea_staging, ]
}

resource "kubernetes_persistent_volume_claim" "gitea_staging-backup-pvc" {
  metadata {
    name = "gitea-staging-backup-pvc"
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
    volume_name = kubernetes_persistent_volume.gitea_staging-backup-pv.metadata.0.name
  }

  depends_on = [ kubernetes_persistent_volume.gitea_staging-backup-pv, ]
}