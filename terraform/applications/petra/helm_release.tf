resource "helm_release" "petra" {
  name      = "petra"
  chart     = "${path.module}/../../../charts/petra" # Is a local chart
  namespace = var.namespace
}
