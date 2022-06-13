locals {
  cluster_name    = "${var.name}-cluster"
  cluster_version = "1.23"
}

module "aws_eks" {
  count  = var.cloud_provider == "aws" ? 1 : 0
  source = "./cluster/aws"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
}

module "azure_aks" {
  count  = var.cloud_provider == "azure" ? 1 : 0
  source = "./cluster/azure"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  azure_region = var.azure_region
}

module "gcp_gke" {
  count  = var.cloud_provider == "gcp" ? 1 : 0
  source = "./cluster/gcp"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  gcp_region = var.gcp_region
}
