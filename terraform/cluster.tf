locals {
  cluster_name    = "${var.name}-cluster"
  cluster_version = "1.23"
}

# TODO: Fix this module
# module "aws_eks" {
#   source = "./cluster/aws"

#   cluster_name    = local.cluster_name
#   cluster_version = local.cluster_version
# }

module "azure_aks" {
  source = "./cluster/azure"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  azure_region = var.azure_region
}

#module "gcp_gke" {
#  source = "./cluster/gcp"
#
#  cluster_name    = local.cluster_name
#  cluster_version = local.cluster_version
#
#  gcp_region = var.gcp_region
#}
