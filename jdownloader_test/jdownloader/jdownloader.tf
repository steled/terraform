resource "kubernetes_deployment" "jdownloader-test" {
  metadata {
    name = "jd-test"
    namespace = var.kubernetes_namespace_name

    labels = {
      app = "jd-sftp-test"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jd-sftp-test"
      }
    }

    template {
      metadata {
        labels = {
          app = "jd-sftp-test"
        }
      }

      spec {
#        restart_policy = "Never"
        security_context {
          run_as_user  = 1000
          run_as_group = 1000
          run_as_non_root = true
        }

        container {
          image = "antlafarge/jdownloader:alpine"
          image_pull_policy = "Always"
          name  = "jd-test"

          env {
            name  = "JD_DEVICENAME"
            value = var.env_JD_DEVICENAME
          }
          env {
            name  = "JD_PASSWORD"
            value = var.env_JD_PASSWORD
          }
          env {
            name  = "JD_EMAIL"
            value = var.env_JD_EMAIL
          }

          port {
            name           = "jd-test"
            container_port = 3129
            protocol       = "TCP"
          }
        
          volume_mount {
            mount_path = "/jdownloader/cfg"
            name       = "config"
          }

          volume_mount {
            mount_path = "/jdownloader/downloads"
            name       = "downloads"
          }

          volume_mount {
            mount_path = "/jdownloader/logs"
            name       = "logs"
          }
        }
        volume {
          name = "config"
          persistent_volume_claim {
            claim_name = var.config_pvc_name
          }
        }

        volume {
          name = "downloads"
          persistent_volume_claim {
            claim_name = var.downloads_pvc_name
          }
        }

        volume {
          name = "logs"
          persistent_volume_claim {
            claim_name = var.logs_pvc_name
          }
        }
      }
    }
  }
}