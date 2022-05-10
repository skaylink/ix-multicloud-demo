rresource "azurerm_resource_group" "main" {
  name     = "${var.cluster_name}-aks-resources"
  location = var.azure_region

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kubernetes_version  = var.kubernetes_version

  lifecycle {
    prevent_destroy = true
  }

  default_node_pool {
    name    = "default"
    vm_size = "Standard_B2ms"

    enable_auto_scaling = true
    min_count           = "1"
    max_count           = "3"
  }

  identity {
    type = "SystemAssigned"
  }
}
