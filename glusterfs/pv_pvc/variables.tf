variable "config_path" {
  type = string
}

variable "kubernetes_namespace_name" {
  type = string
}

variable "glusterfs_endpoints_name" {
  type = string
}

variable "glusterfs_persistent_volume_name" {
  type = string
}

variable "glusterfs_persistent_volume_capacity" {
  type = string
}

variable "glusterfs_persistent_volume_access_mode" {
  type = list(string)
}

variable "glusterfs_persistent_volume_path" {
  type = string
}

variable "glusterfs_persistent_volume_rad_only" {
  type = bool
}

variable "glusterfs_persistent_volume_claim_name" {
  type = string
}

variable "glusterfs_persistent_volume_claim_access_mode" {
  type = list(string)
}

variable "glusterfs_persistent_volume_claim_capacity" {
  type = string
}