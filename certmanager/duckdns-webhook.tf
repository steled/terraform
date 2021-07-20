resource "helm_release" "duckdns_webhook" {
  name       = var.helm_release_name_duckdns_webhook

  repository = "https://ebrianne.github.io/helm-charts"
  chart      = "cert-manager-webhook-duckdns"
  version    = "1.2.3" # check version here: https://github.com/ebrianne/helm-charts/blob/master/charts/cert-manager-webhook-duckdns/Chart.yaml

  values = [ file("duckdns-webhook-values.yaml") ]

  namespace = kubernetes_namespace.certmanager.metadata[0].name
}