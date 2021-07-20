variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "sftp_helm_release_name" {
  type = string
}

variable "env_JD_DEVICENAME" {
  type = string
}

variable "env_JD_PASSWORD" {
  type = string
}

variable "env_JD_EMAIL" {
  type = string
}

variable "config_pv_name" {
  type = string
}

variable "downloads_pv_name" {
  type = string
}

variable "logs_pv_name" {
  type = string
}

variable "config_pvc_name" {
  type = string
}

variable "downloads_pvc_name" {
  type = string
}

variable "logs_pvc_name" {
  type = string
}