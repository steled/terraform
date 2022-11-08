terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.config_path
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}