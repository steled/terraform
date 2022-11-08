resource "kubernetes_manifest" "metallb_ipaddresspool" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind = "IPAddressPool"
    metadata = {
      name = "generic-cluster-pool"
      namespace = kubernetes_namespace.metallb.metadata[0].name
    }
    spec = {
      addresses = [ var.helm_values_addresses ]
    }
  }
}

resource "kubernetes_manifest" "metallb_l2advertisement" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind = "L2Advertisement"
    metadata = {
      name = "generic-cluster-pool"
      namespace = kubernetes_namespace.metallb.metadata[0].name
    }
  }
}