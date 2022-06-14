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
    random = {
      source  = "hashicorp/random"
      version = "3.3.1"
    }
  }
  required_version = ">= 0.14.9"
}

### Azure Cloud

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  features {}
}

provider "kubernetes" {
  alias                  = "azure"
  host                   = module.azure_aks.host
  client_certificate     = base64decode(module.azure_aks.client_certificate)
  client_key             = base64decode(module.azure_aks.client_key)
  cluster_ca_certificate = base64decode(module.azure_aks.cluster_ca_certificate)
}

provider "helm" {
  alias                    = "azure"
  kubernetes {
    host                   = module.azure_aks.host
    client_certificate     = base64decode(module.azure_aks.client_certificate)
    client_key             = base64decode(module.azure_aks.client_key)
    cluster_ca_certificate = base64decode(module.azure_aks.cluster_ca_certificate)
  }
}

### Google Cloud Platform
#provider "google" {
#  project = var.gcp_project_id
#  region  = var.gcp_region
#}
#
#provider "kubernetes" {
#  alias                  = "gcp"
#  host                   =  module.gcp_gke.host
#  client_certificate     =  base64decode(module.gcp_gke.client_certificate)
#  client_key             =  base64decode(module.gcp_gke.client_key)
#  cluster_ca_certificate =  base64decode(module.gcp_gke.cluster_ca_certificate)
#}
#
#provider "helm" {
#  alias                    = "gcp"
#  kubernetes {
#    host                   = module.gcp_gke.host
#    client_certificate     = base64decode(module.gcp_gke.client_certificate)
#    client_key             = base64decode(module.gcp_gke.client_key)
#    cluster_ca_certificate = base64decode(module.gcp_gke.cluster_ca_certificate)
#  }
#}