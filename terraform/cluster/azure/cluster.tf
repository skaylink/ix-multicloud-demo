resource "azurerm_resource_group" "main" {
  name     = "${var.cluster_name}-resources"
  location = var.azure_region
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kubernetes_version  = var.cluster_version
  dns_prefix          = var.cluster_name

  default_node_pool {
    name    = "default"
    vm_size = "standard_d8ads_v5"

    enable_auto_scaling = true
    min_count           = "1"
    max_count           = "3"
  }

  identity {
    type = "SystemAssigned"
  }
}
