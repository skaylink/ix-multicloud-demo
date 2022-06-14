####################################################
# Common variables
####################################################
variable "name" {
  type = string
}

variable "klaus_provider" {
  type = string

  validation {
    condition     = contains(["azure", "gcp", "aws"], var.klaus_provider)
    error_message = "Allowed values for input_parameter are \"azure\", \"gcp\" or \"aws\" (currently disabled)."
  }
}

variable "petra_provider" {
  type = string

  validation {
    condition     = contains(["azure", "gcp", "aws"], var.petra_provider)
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
