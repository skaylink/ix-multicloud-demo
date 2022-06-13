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
  host                   = module.azure_aks.0.host
  client_certificate     = base64decode(module.azure_aks.0.client_certificate)
  client_key             = base64decode(module.azure_aks.0.client_key)
  cluster_ca_certificate = base64decode(module.azure_aks.0.cluster_ca_certificate)

  alias = "azure"
}

provider "helm" {
  kubernetes {
    host                   = module.azure_aks.0.host
    client_certificate     = base64decode(module.azure_aks.0.client_certificate)
    client_key             = base64decode(module.azure_aks.0.client_key)
    cluster_ca_certificate = base64decode(module.azure_aks.0.cluster_ca_certificate)
  }

  alias = "azure"
}

### Google Cloud Platform

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "kubernetes" {
  host                   = module.gcp_gke.0.host
  client_certificate     = base64decode(module.gcp_gke.0.client_certificate)
  client_key             = base64decode(module.gcp_gke.0.client_key)
  cluster_ca_certificate = base64decode(module.gcp_gke.0.cluster_ca_certificate)

  alias = "gcp"
}

provider "helm" {
  kubernetes {
    host                   = module.gcp_gke.0.host
    client_certificate     = base64decode(module.gcp_gke.0.client_certificate)
    client_key             = base64decode(module.gcp_gke.0.client_key)
    cluster_ca_certificate = base64decode(module.gcp_gke.0.cluster_ca_certificate)
  }

  alias = "gcp"
}

### Amazon Web Service

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "kubernetes" {
  host                   = module.aws_eks.0.host
  client_certificate     = base64decode(module.aws_eks.0.client_certificate)
  client_key             = base64decode(module.aws_eks.0.client_key)
  cluster_ca_certificate = base64decode(module.aws_eks.0.cluster_ca_certificate)

  alias = "aws"
}

provider "helm" {
  kubernetes {
    host                   = module.aws_eks.0.host
    client_certificate     = base64decode(module.aws_eks.0.client_certificate)
    client_key             = base64decode(module.aws_eks.0.client_key)
    cluster_ca_certificate = base64decode(module.aws_eks.0.cluster_ca_certificate)
  }

  alias = "aws"
}
