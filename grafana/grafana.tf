resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "grafana" {
  name       = var.helm_release_name

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.6.2"

  values = [ file("values.yaml") ]

  namespace = kubernetes_namespace.monitoring.metadata[0].name

  depends_on = [ module.glusterfs_endpoints_service, module.glusterfs_pv_pvc, ]
}