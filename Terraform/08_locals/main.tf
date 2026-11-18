locals {
    prefix          = "nextops"
    vnet_name_ref   = azurerm_virtual_network.vnet1.name
    rg_name_ref     = azurerm_resource_group.rg1.name
    rg_location_ref = azurerm_resource_group.rg1.location
}

resource "azurerm_resource_group" "rg1" {
  name      = join("-", [local.prefix,var.rg_name])       #nextops-localrg
  location  = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
  name                  = join("-", [local.prefix,var.vnet_name])  #nextops-localvnet
  resource_group_name   = local.rg_name_ref
  location              = local.rg_location_ref
  address_space         = var.address_space
}

resource "azurerm_subnet" "subnet1" {
  name                  = join("-", [local.prefix,var.subnet_name])  #nextops-localsubnet1    
  virtual_network_name  = local.vnet_name_ref
  resource_group_name   = local.rg_name_ref
  address_prefixes      = var.address_prefix
}
