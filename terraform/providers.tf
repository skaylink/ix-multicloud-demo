# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.13.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
  required_version = ">= 0.14.9"
}

provider "kubernetes" {
  host                   = module.azure_aks.host
  client_certificate     = base64decode(module.azure_aks.client_certificate)
  client_key             = base64decode(module.azure_aks.client_key)
  cluster_ca_certificate = base64decode(module.azure_aks.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = module.azure_aks.host
    client_certificate     = base64decode(module.azure_aks.client_certificate)
    client_key             = base64decode(module.azure_aks.client_key)
    cluster_ca_certificate = base64decode(module.azure_aks.cluster_ca_certificate)
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  features {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
