variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "drone_helm_release_name" {
  type = string
}

variable "drone_kubernetes_secrets_helm_release_name" {
  type = string
}

variable "drone_runner_kube_helm_release_name" {
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

variable "drone_server_host" {
  type = string
}

variable "drone_gitea_server" {
  type = string
}

variable "gluster" {
  type    = map
}