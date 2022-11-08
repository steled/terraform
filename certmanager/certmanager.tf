resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "certmanager" {
  name       = var.helm_release_name_certmanager

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.9.1" # check version here: https://artifacthub.io/packages/helm/cert-manager/cert-manager/

  set {
    name = "installCRDs"
    value = "true"
  }

  namespace = kubernetes_namespace.certmanager.metadata[0].name
}
