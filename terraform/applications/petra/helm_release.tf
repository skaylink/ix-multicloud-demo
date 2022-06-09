data "kubernetes_namespace" "petra" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "petra" {
  name      = "petra"
  chart     = "${path.module}/../../../charts/petra" # Is a local chart
  namespace = data.kubernetes_namespace.petra.metadata[0].name
}
