resource "kubernetes_config_map" "sdm" {
  metadata {
    name = "smarter-device-manager"
    namespace = var.kubernetes_namespace_name
  }

  data = {
    "conf.yaml" = <<CONF
- devicematch: ^gpiomem$
  nummaxdevices: 1
CONF
  }
}

resource "kubernetes_deployment" "sdm" {
  metadata {
    name      = "smarter-device-manager"
    namespace = var.kubernetes_namespace_name
    labels = {
      app = "sdm"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "sdm"
      }
    }

    template {
      metadata {
        labels = {
          app = "sdm"
        }
      }

      spec {
        node_name = var.node_name

        container {
          image = var.image
          name  = "smarter-device-manager"

          security_context {
            allow_privilege_escalation = false

            capabilities {
              drop = [ "ALL" ]
            }
          }

          resources {
            limits = {
              "cpu"    = "100m"
              "memory" = "15Mi"
            }
            requests = {
              "cpu"    = "10m"
              "memory" = "15Mi"
            }
          }

          volume_mount {
            name       = "device-plugin"
            mount_path = "/var/lib/kubelet/device-plugins"
          }
          volume_mount {
            name       = "dev-dir"
            mount_path = "/dev"
          }
          volume_mount {
            name       = "sys-dir"
            mount_path = "/sys"
          }
          volume_mount {
            name       = "config"
            mount_path = "/root/config"
          }
        }

        volume {
          name = "device-plugin"
          host_path {
            path = "/var/lib/kubelet/device-plugins"
          }
        }
        volume {
          name = "dev-dir"
          host_path {
            path = "/dev"
          }
        }
        volume {
          name = "sys-dir"
          host_path {
            path = "/sys"
          }
        }
        volume {
          name = "config"
          config_map {
            name = "smarter-device-manager"
          }
        }
      }
    }
  }
}