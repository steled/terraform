resource "kubernetes_secret" "gitea-admin-secret" {
  metadata {
    name      = "gitea-admin-secret"
    namespace = var.kubernetes_namespace_name
  }

  data = {
    username = var.gitea_admin_username
    password = var.gitea_admin_password
  }

  type = "Opaque"
}