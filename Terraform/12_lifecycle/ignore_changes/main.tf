resource "azurerm_resource_group" "myrg" {
  name      = "MyRG"          #Required
  location  = "eastus"          #Required

  lifecycle {
    ignore_changes = [ tags ]
  }
}

resource "azurerm_virtual_network" "myvnet" {
  name                  = "Myvnet"
  location              = azurerm_resource_group.myrg.location
  resource_group_name   = azurerm_resource_group.myrg.name
  address_space         = ["10.10.0.0/16"]
  
  lifecycle {
    ignore_changes = [ address_space ]
  }
}

resource "azurerm_subnet" "subnet1" {
  name                  = "subnet01"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = ["10.10.0.0/24"]  
}