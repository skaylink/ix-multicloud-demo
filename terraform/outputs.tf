
output "aws_ingress_url" {
  value = ""#module.aws_aks.host
}

output "azure_ingress_url" {
  value = nonsensitive(module.azure_aks.host)
}

output "gcp_ingress_url" {
  value = nonsensitive(module.gcp_gke.0.host)
} 

output "klaus_url" {
  value = nonsensitive(module.azure_aks.host)
} 