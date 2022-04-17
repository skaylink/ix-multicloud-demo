# Case Azure
resource "azurerm_resource_group" "cluster-azure" {
  count = var.cloud_provider == "azure" ? 1 : 0
  #name = var.name
  name = "cluster-at-azure"
  location = "eastus"
}

# Case AWS
resource "azurerm_resource_group" "cluster-aws" {
  count = var.cloud_provider == "aws" ? 1 : 0
  #name = var.name
  name = "cluster-at-aws"
  location = "eastus"
}