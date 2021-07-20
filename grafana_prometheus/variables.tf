variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "grafana_helm_release_name" {
  type = string
}

variable "prometheus_helm_release_name" {
  type = string
}

variable "glusterfs_endpoints_name" {
  type = string
}

variable "glusterfs_endpoints_address" {
  type = list(string)
}

variable "glusterfs_endpoints_port" {
  type = string
}

variable "glusterfs_service_name" {
  type = string
}

variable "glusterfs_service_port" {
  type = string
}

variable "gluster" {
  type    = map
}