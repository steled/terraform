resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "nginx" {
  name       = var.helm_release_name

  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "0.9.1"

  values = [ file("values.yaml") ]
#  values = [ templatefile("values.yaml", { gitea_domain = var.gitea_domain }) ]

  namespace = kubernetes_namespace.nginx.metadata[0].name
}