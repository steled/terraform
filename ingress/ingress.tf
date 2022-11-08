resource "kubernetes_namespace" "ingress" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "ingress" {
  name          = var.helm_release_name

  repository    = "https://kubernetes.github.io/ingress-nginx"
  chart         = "ingress-nginx"
  version       = "4.2.5" # check version here: https://github.com/kubernetes/ingress-nginx/blob/master/charts/ingress-nginx/Chart.yaml
  force_update  = false
  recreate_pods = true

  values        = [ file("values.yaml") ]

  namespace     = kubernetes_namespace.ingress.metadata[0].name
}
