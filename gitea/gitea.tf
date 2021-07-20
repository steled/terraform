resource "kubernetes_namespace" "gitea" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "gitea" {
  name       = var.helm_release_name

  repository = "https://dl.gitea.io/charts/"
  chart      = "gitea"
  version    = "3.0.0" # check version here: https://gitea.com/gitea/helm-chart/src/branch/master/Chart.yaml

#  values = [ file("values.yaml") ]
  values = [ templatefile("values.yaml", { gitea_domain = var.gitea_domain, environment = var.environment }) ]

  namespace = kubernetes_namespace.gitea.metadata[0].name
}