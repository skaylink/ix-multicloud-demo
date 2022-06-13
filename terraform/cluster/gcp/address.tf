# Static Regional IP Address
# See https://github.com/kubernetes/ingress-nginx/issues/1281
# See https://stackoverflow.com/questions/48763805/does-gke-support-nginx-ingress-with-static-ip
resource "google_compute_address" "ingress" {
  name   = "ingress-controller"
  region = var.gcp_region
}
