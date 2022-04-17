# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  features {}
}


module "azure-function-queries" {
  source = "./modules/kubernetes"
  
  name     = var.name
  cloud_provider = "azure"
}

