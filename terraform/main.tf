# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id = var.azure_tenant_id
  features {}
}


provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

module "kubernetes-petra" {
  source = "./modules/kubernetes"
  name = var.name
  cloud_provider = var.cloud_provider
  azure_region = var.azure_region
  aws_region = var.aws_region
}


module "kubernetes-klaus" {
  source = "./modules/kubernetes"
  name = var.name
  cloud_provider = var.cloud_provider
  azure_region = var.azure_region
  aws_region = var.aws_region
}

