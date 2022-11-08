resource "kubernetes_namespace" "metallb" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "metallb" {
  name          = var.helm_release_name

  repository    = "https://charts.bitnami.com/bitnami"
  chart         = "metallb"
  version       = "4.1.2" # check version here: https://github.com/bitnami/charts/blob/master/bitnami/metallb/Chart.yaml
  recreate_pods = true

  values = [ file("values.yaml") ]

  namespace     = kubernetes_namespace.metallb.metadata[0].name

  depends_on    = [ kubernetes_namespace.metallb, ]
}
