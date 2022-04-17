####################################################
# Case Azure
####################################################
resource "azurerm_resource_group" "cluster-azure" {
  count = var.cloud_provider == "azure" ? 1 : 0
  name = var.name
  location = var.azure_region
}

####################################################
# Case AWS
####################################################
resource "aws_s3_bucket" "cluster-aws" {
  count = var.cloud_provider == "aws" ? 1 : 0
  bucket = var.name
  force_destroy = true
}