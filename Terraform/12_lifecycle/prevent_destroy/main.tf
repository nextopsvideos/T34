
resource "azurerm_resource_group" "myrg" {
  name      = "TFRg"          #Required
  location  = "eastus"          #Required

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_virtual_network" "myvnet" {
  name                  = "TFvnet"
  location              = azurerm_resource_group.myrg.location
  resource_group_name   = azurerm_resource_group.myrg.name
  address_space         = ["10.0.0.0/16"]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "subnet1" {
  name                  = "subnet01"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = ["10.0.0.0/24"]
  
}