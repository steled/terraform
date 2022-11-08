terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
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