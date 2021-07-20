terraform {
  required_providers {
    k8s = {
      source  = "banzaicloud/k8s"
      version = "0.9.0"
    }
  }
}

provider "k8s" {
  config_path = var.config_path
}

provider "kubernetes" {
  config_path = var.config_path
}

data "http" "dashboard" {
  url = var.url
}

locals {
  resources_0 = split("\n---\n",data.http.dashboard.body)
  resources_1 = slice(local.resources_0, 0, 2)
  resources_2 = slice(local.resources_0, 3, length(local.resources_0))
  resources = concat(local.resources_1, local.resources_2)
}

resource "k8s_manifest" "kubernetes_dashboard" {
  count   = length(local.resources)
  content = local.resources[count.index]
}

resource "kubernetes_service" "kubernetes_dashboard" {
  metadata {
    labels = {
      "k8s-app" = "kubernetes-dashboard"
    }
    name      = "kubernetes-dashboard"
    namespace = var.namespace
  }
  spec {
    port {
      port = "443"
      target_port = "8443"
    }
    selector = {
      "k8s-app" = "kubernetes-dashboard"
    }
    type = "LoadBalancer"
  }

  depends_on = [ k8s_manifest.kubernetes_dashboard ]
}

resource "kubernetes_service_account" "kubernetes_dashboard" {
  metadata {
    name      = var.username
    namespace = var.namespace
  }

  depends_on = [ k8s_manifest.kubernetes_dashboard ]
}

data "kubernetes_secret" "admin" {
  metadata {
    name      = kubernetes_service_account.kubernetes_dashboard.default_secret_name
    namespace = var.namespace
  }

  depends_on = [ kubernetes_service_account.kubernetes_dashboard ]
}

resource "kubernetes_cluster_role_binding" "kubernetes_dashboard" {
  metadata {
    name      = var.username
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.username
    namespace = var.namespace
  }

  depends_on = [ kubernetes_service_account.kubernetes_dashboard ]
}