variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "helm_release_name" {
  type = string
}

variable "nextcloud_domain" {
  type = string
}

variable "environment" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "nextcloud_admin_username" {
  type = string
}

variable "nextcloud_admin_password" {
  type = string
}

variable "nextcloud_proxies" {
  type = string
}

variable "mail_fromaddress" {
  type = string
}

variable "mail_domain" {
  type = string
}

variable "smtp_host" {
  type = string
}

variable "smtp_secure" {
  type = string
}

variable "smtp_port" {
  type = string
}

variable "smtp_authtype" {
  type = string
}

variable "nextcloud_smtp_username" {
  type = string
}

variable "nextcloud_smtp_password" {
  type = string
}

variable "externaldatabase_user" {
  type = string
}

variable "externaldatabase_password" {
  type = string
}

variable "externaldatabase_database" {
  type = string
}

variable "postgresql_postgresqladminpassword" {
  type = string
}

variable "postgresql_postgresqlusername" {
  type = string
}

variable "postgresql_postgresqlpassword" {
  type = string
}

variable "postgresql_postgresqldatabase" {
  type = string
}