resource "google_service_account" "default" {
  account_id   = "${var.cluster_name}"
  display_name = "Cluster Service Account for ${var.cluster_name}"
}
