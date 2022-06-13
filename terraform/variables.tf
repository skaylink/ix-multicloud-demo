####################################################
# Common variables
####################################################
variable "name" {
  type = string
}

variable "cloud_provider" {
  type = string

  validation {
    condition     = contains(["azure", "gcp"], var.cloud_provider) # TODO: Add AWS back
    error_message = "Allowed values for input_parameter are \"azure\", \"gcp\" or \"aws\" (currently disabled)."
  }
}

variable "ingress_domain" {
  type = string
}

####################################################
# Provider-specific variables
####################################################

# Azure
variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_region" {
  type = string
}

# GCP
variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

# AWS
variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}
