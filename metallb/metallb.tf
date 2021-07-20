resource "kubernetes_namespace" "metallb" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "metallb" {
  name       = var.helm_release_name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metallb"
  version    = "2.4.0" # check version here: https://github.com/bitnami/charts/blob/master/bitnami/metallb/Chart.yaml

#  values = [ file("values.yaml") ]
  values = [ templatefile("values.yaml", { addresses = var.helm_values_addresses }) ]

  namespace = kubernetes_namespace.metallb.metadata[0].name

  depends_on = [ kubernetes_namespace.metallb, ]
}