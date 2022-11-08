resource "kubernetes_deployment" "dht22" {
  metadata {
    name      = "dht22"
    namespace = var.kubernetes_namespace_name
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

        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/path"   = "/"
          "prometheus.io/port"   = "9100"
        }
      }

      spec {
        node_name = var.node_name

        container {
          image = var.image
          name  = "dht22"
          args  = [ "-g", "D2", "-i", "5" ]
          port {
            name = "metrics"
            container_port = 9100
          }
#          security_context {
#            capabilities {
#              add = [ "SYS_RAWIO" ]
#            }
#          }

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
      }
    }
  }
}