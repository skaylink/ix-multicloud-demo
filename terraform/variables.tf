####################################################
# Common variables
####################################################
variable "name" {
  type = string
}

variable "cloud_provider" {
  type = string

  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Allowed values for input_parameter are \"azure\" or \"aws\"."
  }
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

# AWS
variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}
