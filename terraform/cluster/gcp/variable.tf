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
