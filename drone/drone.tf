resource "helm_release" "drone" {
  name       = var.drone_helm_release_name

  repository = "https://charts.drone.io"
  chart      = "drone"
  version    = "0.1.7"

#  values = [ file("drone-values.yaml") ]
  values = [ templatefile("drone-values.yaml", { drone_server_host = var.drone_server_host, drone_gitea_server = var.drone_gitea_server }) ]

  namespace = kubernetes_namespace.drone.metadata[0].name

  depends_on = [ module.glusterfs_pv_pvc, ]
}

resource "helm_release" "drone-kubernetes-secrets" {
  name       = var.drone_kubernetes_secrets_helm_release_name

  repository = "https://charts.drone.io"
  chart      = "drone-kubernetes-secrets"
  version    = "0.1.1"

  values = [ file("drone-kubernetes-secrets-values.yaml") ]

  namespace = kubernetes_namespace.drone.metadata[0].name

  depends_on = [ helm_release.drone, ]
}

resource "helm_release" "drone-runner-kube" {
  name       = var.drone_runner_kube_helm_release_name

  repository = "https://charts.drone.io"
  chart      = "drone-runner-kube"
  version    = "0.1.5"

  values = [ file("drone-runner-kube-values.yaml") ]

  namespace = kubernetes_namespace.drone.metadata[0].name

  depends_on = [ helm_release.drone, ]
}