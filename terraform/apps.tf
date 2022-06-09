resource "random_uuid" "kubernetes_dashboard_csrf" {
}

module "kubernetes_dashboard" {
  source  = "cookielab/dashboard/kubernetes"
  version = "0.9.0"

  kubernetes_namespace_create = true
  kubernetes_dashboard_csrf   = random_uuid.kubernetes_dashboard_csrf.result
}

module "nginx-controller" {
  source = "terraform-iaac/nginx-controller/helm"

  # TODO: Make this only when gcp is in place
  # ip_address = google_compute_address.ingress_ip_address.address
}

# Application Components:

resource "kubernetes_namespace" "group" {
  metadata {
    name = "group"
  }
}

module "petra" {
  source = "./applications/petra"
  depends_on = [
    kubernetes_namespace.group
  ]

  namespace = kubernetes_namespace.group.metadata.0.name
}


module "klaus" {
  source = "./applications/klaus"
  depends_on = [
    kubernetes_namespace.group
  ]

  namespace          = kubernetes_namespace.group.metadata.0.name
  ingress_class_name = "nginx"
  ingress_domain     = var.ingress_domain
}
