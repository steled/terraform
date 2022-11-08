resource "helm_release" "sftp" {
  name       = var.helm_release_name

#  repository = "https://grafana.github.io/helm-charts"
#  chart      = "https://github.com/openvnf/sftp-server/archive/refs/tags/v0.3.2.tar.gz"
  chart      = "https://github.com/steled/sftp-server/archive/refs/tags/v0.3.5.tar.gz"
#  version    = "0.3.2"

  values = [ file("${path.module}/values.yaml") ]

  namespace = var.kubernetes_namespace_name
}