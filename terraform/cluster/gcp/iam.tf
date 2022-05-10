resource "google_service_account" "default" {
  account_id   = "${var.cluster_name}-cluster-sa"
  display_name = "Cluster Service Account for ${var.cluster_name}"
}
