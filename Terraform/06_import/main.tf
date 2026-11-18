
resource "azurerm_resource_group" "myrg" {
    name        = "NextOpsRGT34"
    location    = "eastus"
    tags = {
        env = "dev",
        createdby = "Charan",
        creationDate = "18112026"
    }
}

resource "azurerm_virtual_network" "myvnet" {
    name                = "NextOpsVNETT34"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
    address_space       = ["10.0.0.0/16"]      # Class B - 65536 IP Addresses
    tags = {
        env = "dev",
        createdby = "Charan",
        creationDate = "18112026"
    }
}

resource "azurerm_subnet" "subnet1" {
    name                        = "subnet1"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.0.0.0/24"] #256 ip addresses 
    default_outbound_access_enabled = false 
}

resource "azurerm_subnet" "subnet2" {
    name                        = "subnet2"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.0.1.0/24"] #256 ip addresses
    default_outbound_access_enabled = false  
}