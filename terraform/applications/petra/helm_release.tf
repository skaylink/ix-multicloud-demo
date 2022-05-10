data "kubernetes_namespace" "petra" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "petra" {
  name      = "petra"
  chart     = "../../charts/petra" # Is a local chart
  namespace = data.kubernetes_namespace.petra.metadata[0].name
}
