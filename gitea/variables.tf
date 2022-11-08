variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "helm_release_name" {
  type = string
}

variable "gitea_domain" {
  type = string
}

variable "environment" {
  type = string
}

variable "gitea_admin_username" {
  type = string
}

variable "gitea_admin_password" {
  type = string
}

variable "gitea_admin_email" {
  type = string
}

variable "gitea_oauth2_jwt_secret" {
  type = string
}

variable "gitea_security_internal_token" {
  type = string
}

variable "gitea_security_secret_key" {
  type = string
}

variable "gitea_server_lfs_jwt_secret" {
  type = string
}