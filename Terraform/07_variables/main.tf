resource "azurerm_resource_group" "rg1" {
    name     = var.rg_name          #DEVAKSRG
    location = var.rg_location      #eastus    
}

resource "azurerm_container_registry" "acr1" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  sku                 = var.acr_sku
}

resource "azurerm_kubernetes_cluster" "aks1" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  dns_prefix          = var.aks_dns_prefix

  node_provisioning_profile {
    default_node_pools = "Auto" 
    mode = "Auto"
  }

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    env = var.aks_env
  }
}

resource "azurerm_role_assignment" "aks2acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks1.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr1.id
  skip_service_principal_aad_check = true
}