variable "cluster_name" {
  type        = string
  description = "The base name of the cluster and it's resources."
}

variable "cluster_version" {
  type        = string
  default     = "1.23"
  description = "A valid kubernetes release version, e.g. 1.23 or 1.24"
}

variable "gcp_region" {
  type        = string
  description = "GCP Region where the cluster gets deployed."
}

### Outputs
output "client_key" {
  value     = google_container_cluster.primary.master_auth[0].client_key
  sensitive = true
}

output "client_certificate" {
  value     = google_container_cluster.primary.master_auth[0].client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive = true
}

output "host" {
  value = google_container_cluster.primary.endpoint
}

output "ingress_address" {
  value = google_compute_address.ingress.address
}
