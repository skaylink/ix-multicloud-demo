module "nginx_controller" {
  source = "terraform-iaac/nginx-controller/helm"

  # This is required only for gcp
  ip_address = var.cloud_provider == "gcp" ? module.gcp_gke.0.ingress_address : ""
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

  providers = {
    helm = helm.azure
  }

  namespace = kubernetes_namespace.group.metadata.0.name
}

module "klaus" {
  source = "./applications/klaus"
  depends_on = [
    kubernetes_namespace.group,
    module.nginx_controller
  ]

  namespace          = kubernetes_namespace.group.metadata.0.name
  ingress_class_name = "nginx"
  ingress_domain     = var.ingress_domain
}
