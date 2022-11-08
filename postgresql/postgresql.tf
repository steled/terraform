resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "postgresql" {
  name       = var.helm_release_name

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "11.1.1" # take care of update path; check version here: https://github.com/nextcloud/helm/blob/master/charts/nextcloud/Chart.yaml
  recreate_pods = true

  values = [ templatefile("values.yaml", {
    postgresql_postgresqladminpassword = var.postgresql_postgresqladminpassword,
    postgresql_postgresqlusername = var. postgresql_postgresqlusername,
    postgresql_postgresqlpassword = var.postgresql_postgresqlpassword,
    postgresql_postgresqldatabase = var.postgresql_postgresqldatabase
  }) ]

  namespace = kubernetes_namespace.postgresql.metadata[0].name
}