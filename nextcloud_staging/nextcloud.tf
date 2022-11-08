resource "kubernetes_namespace" "nextcloud" {
  metadata {
    name = var.kubernetes_namespace_name
  }
}

resource "helm_release" "nextcloud" {
  name       = var.helm_release_name

  repository = "https://nextcloud.github.io/helm/"
  chart      = "nextcloud"
  version    = "3.1.2" # take care of update path; check version here: https://github.com/nextcloud/helm/blob/master/charts/nextcloud/Chart.yaml
  recreate_pods = true

  values = [ templatefile("values.yaml", {
    nextcloud_domain = var.nextcloud_domain,
    environment = var.environment,
    ip_address = var.ip_address,
    nextcloud_proxies = var.nextcloud_proxies
    mail_fromaddress = var.mail_fromaddress
    mail_domain = var.mail_domain
    smtp_host = var.smtp_host
    smtp_secure = var.smtp_secure
    smtp_port = var.smtp_port
    smtp_authtype = var.smtp_authtype
    externaldatabase_user = var.externaldatabase_user,
    externaldatabase_password = var.externaldatabase_password,
    externaldatabase_database = var.externaldatabase_database,
    postgresql_postgresqladminpassword = var.postgresql_postgresqladminpassword,
    postgresql_postgresqlusername = var. postgresql_postgresqlusername,
    postgresql_postgresqlpassword = var.postgresql_postgresqlpassword,
    postgresql_postgresqldatabase = var.postgresql_postgresqldatabase
  }) ]

  namespace = kubernetes_namespace.nextcloud.metadata[0].name

  depends_on = [ kubernetes_secret.nextcloud-secret ]
}