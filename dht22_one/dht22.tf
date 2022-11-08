resource "kubernetes_namespace" "dht22" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "kubernetes_config_map" "smarter_device_manager" {
  metadata {
    name = "smarter-device-manager-rpi"
    namespace = kubernetes_namespace.dht22.metadata[0].name
  }

  data = {
    "conf.yaml" = <<CONF
- devicematch: ^gpiomem$
  nummaxdevices: 1
CONF
  }
}

resource "kubernetes_deployment" "dht22" {
  metadata {
    name      = "dht22"
    namespace = kubernetes_namespace.dht22.metadata[0].name
    labels = {
      app = "dht22"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dht22"
      }
    }

    template {
      metadata {
        labels = {
          app = "dht22"
        }
      }

      spec {
        node_name = "central01"

        container {
          image = "registry.gitlab.com/arm-research/smarter/smarter-device-manager:v1.20.7"
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

        container {
          image = "steled/dht22:latest-arm64"
          name  = "dht22"
          security_context {
            capabilities {
              add = [ "SYS_RAWIO" ]
            }
          }

          resources {
            limits = {
              "smarter-devices/gpiomem" = "1"
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              "smarter-devices/gpiomem" = "1"
              cpu    = "250m"
              memory = "50Mi"
            }
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
            name = "smarter-device-manager-rpi"
          }
        }
      }
    }
  }
}