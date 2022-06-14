
output "aws_ingress_url" {
  value = ""#module.aws_eks.host
}

output "azure_ingress_url" {
  value = module.azure_aks.host
}

output "gcp_ingress_url" {
  value = ""#module.gcp_gke.host
} 

output "klaus_url" {
  value = module.azure_aks.host
} 