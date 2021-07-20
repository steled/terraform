resource "kubernetes_namespace" "nextcloud" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "nextcloud" {
  name       = var.helm_release_name

  repository = "https://nextcloud.github.io/helm/"
  chart      = "nextcloud"
  version    = "2.6.5" # check version here: https://github.com/nextcloud/helm/blob/master/charts/nextcloud/Chart.yaml
#  recreate_pods = true

#  values = [ file("values.yaml") ]
  values = [ templatefile("values.yaml", { nextcloud_domain = var.nextcloud_domain, environment = var.environment }) ]

  namespace = kubernetes_namespace.nextcloud.metadata[0].name
}