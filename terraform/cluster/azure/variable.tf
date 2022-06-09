variable "cluster_name" {
  type        = string
  description = "The base name of the cluster and it's resources."
}

variable "cluster_version" {
  type        = string
  default     = "1.23"
  description = "A valid kubernetes release version, e.g. 1.23 or 1.24"
}

variable "azure_region" {
  type = string
}

### Outputs

output "client_key" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].client_key
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.main.kube_config[0].host
}

output "username" {
  value = azurerm_kubernetes_cluster.main.kube_config[0].username
}

output "password" {
  value     = azurerm_kubernetes_cluster.main.kube_config[0].password
  sensitive = true
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.main.node_resource_group
}

output "location" {
  value = azurerm_kubernetes_cluster.main.location
}

output "id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "kube_config_raw" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
}

output "kube_admin_config_raw" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_admin_config_raw
}

output "system_assigned_identity" {
  value = azurerm_kubernetes_cluster.main.identity
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.main.kubelet_identity
}

output "admin_client_key" {
  value     = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key : ""
  sensitive = true
}

output "admin_client_certificate" {
  value     = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate : ""
  sensitive = true
}

output "admin_cluster_ca_certificate" {
  value     = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate : ""
  sensitive = true
}

output "admin_host" {
  value = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.host : ""
}

output "admin_username" {
  value = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.username : ""
}

output "admin_password" {
  value     = length(azurerm_kubernetes_cluster.main.kube_admin_config) > 0 ? azurerm_kubernetes_cluster.main.kube_admin_config.0.password : ""
  sensitive = true
}
