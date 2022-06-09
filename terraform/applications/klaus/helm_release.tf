data "kubernetes_namespace" "klaus" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "klaus" {
  name      = "klaus"
  chart     = "../../charts/klaus" # Is a local chart
  namespace = data.kubernetes_namespace.klaus.metadata[0].name

  # Ingress Base Configuration
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.className"
    value = var.ingress_class_name
  }

  # Ingress Paths Configuration
  set {
    name  = "ingress.hosts[0].host"
    value = var.ingress_domain
  }
  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }
  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "ImplementationSpecific"
  }
}
