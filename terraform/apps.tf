# System Components:

module "metrics_server" {
  source  = "iplabs/metrics-server/kubernetes"
  version = "1.0.0"
}

resource "random_uuid" "kubernetes_dashboard_csrf" {
}

module "kubernetes_dashboard" {
  depends_on = [
    module.metrics_server
  ]

  source  = "cookielab/dashboard/kubernetes"
  version = "0.9.0"

  kubernetes_namespace_create = true
  kubernetes_dashboard_csrf   = random_uuid.kubernetes_dashboard_csrf
}

module "nginx-controller" {
  source = "terraform-iaac/nginx-controller/helm"

  # TODO: Make this only when gcp is in place
  ip_address = google_compute_address.ingress_ip_address.address
}

# Application Components:

module "petra" {
  source = "./applications/petra"
}


module "klaus" {
  source = "./applications/klaus"
  # TODO: Missing parameters
}
