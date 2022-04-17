####################################################
# Common variables
####################################################
variable "name" {
  type = string
}

variable "cloud_provider" {
  type = string
}


####################################################
# Provider-specific variables
####################################################
# Azure
variable "azure_region" {
  type = string
}

# AWS
variable "aws_region" {
  type = string
}