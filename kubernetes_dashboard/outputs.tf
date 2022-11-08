output "service_account_token" {
  value = lookup(data.kubernetes_secret.admin.data, "token")
  depends_on = [ kubernetes_service_account.kubernetes_dashboard ]
}