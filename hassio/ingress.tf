resource "kubernetes_ingress" "hassio" {
  metadata {
    name        = var.metadata_name
    namespace   = kubernetes_namespace.hassio.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx-internal"
      "cert-manager.io/cluster-issuer" = "duckdns-webhook-cert-manager-webhook-duckdns-production"
      "nginx.org/server-snippets" = <<EOF
        location / {
          proxy_set_header Host $host;
          proxy_redirect http:// https://;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
        }
        EOF
    }
  }

  spec {
    rule {
      host = "h4s5.5p4c3.duckdns.org"
      http {
        path {
          backend {
            service_name = var.metadata_name
            service_port = 443
          }

          path = "/"
        }
      }
    }

    tls {
      hosts = ["h4s5.5p4c3.duckdns.org"]
      secret_name = "hassio-secret"
    }
  }
}