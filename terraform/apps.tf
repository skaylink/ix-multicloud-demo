

resource "kubernetes_namespace" "azure_group" {
  metadata {
    name = "group"
  }
  provider = kubernetes.azure
}

resource "kubernetes_namespace" "gcp_group" {
  metadata {
    name = "group"
  }
  provider = kubernetes.gcp
}

### Azure cluster apps
module "azure_nginx_controller" {
  source = "terraform-iaac/nginx-controller/helm"

  providers = {
    helm = helm.azure
  }
}

module "azure_petra" {
  count  = var.petra_provider == "azure" ? 1 : 0
  source = "./applications/petra"
  depends_on = [
    kubernetes_namespace.azure_group
  ]

  providers = {
    helm = helm.azure
  }

  namespace = kubernetes_namespace.azure_group.metadata.0.name
}

module "azure_klaus" {
  count  = var.klaus_provider == "azure" ? 1 : 0
  source = "./applications/klaus"
  depends_on = [
    kubernetes_namespace.azure_group,
    module.azure_nginx_controller
  ]

  namespace          = kubernetes_namespace.azure_group.metadata.0.name
  ingress_class_name = "nginx"
  ingress_domain     = var.ingress_domain

  providers = {
    helm = helm.azure
  }
}

### GCP cluster apps
module "gcp_nginx_controller" {
  source = "terraform-iaac/nginx-controller/helm"
  ip_address = module.gcp_gke.0.ingress_address

  providers = {
    helm = helm.gcp
  }
}

module "gcp_petra" {
  count  = var.petra_provider == "gcp" ? 1 : 0
  source = "./applications/petra"
  depends_on = [
    kubernetes_namespace.gcp_group
  ]

  providers = {
    helm = helm.gcp
  }

  namespace = kubernetes_namespace.gcp_group.metadata.0.name
}

module "gcp_klaus" {
  count  = var.klaus_provider == "gcp" ? 1 : 0
  source = "./applications/klaus"
  depends_on = [
    kubernetes_namespace.gcp_group,
    module.gcp_nginx_controller
  ]

  namespace          = kubernetes_namespace.gcp_group.metadata.0.name
  ingress_class_name = "nginx"
  ingress_domain     = var.ingress_domain

  providers = {
    helm = helm.gcp
  }
}
