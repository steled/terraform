resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "prometheus" {
  name       = var.helm_release_name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "13.6.0"

  values = [ file("values.yaml") ]

  namespace = kubernetes_namespace.monitoring.metadata[0].name

  depends_on = [ module.glusterfs_endpoints_service, module.glusterfs_pv_pvc, ]
}