# tf_keyword "resourc_type" "codeblock_name" {
#     key1 = value1
#     key2 = value2
# }

resource "azurerm_resource_group" "myrg" {
    name        = "NextOpsRGT34"
    location    = "eastus"
}

resource "azurerm_virtual_network" "myvnet" {
    name                = "NextOpsVNETT34"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
    address_space       = ["10.10.0.0/16"]      # Class B - 65536 IP Addresses
}

resource "azurerm_subnet" "subnet1" {
    name                        = "WebSubnet"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.10.0.0/24"] #256 ip addresses  
}

resource "azurerm_subnet" "subnet2" {
    name                        = "DBSubnet"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.10.1.0/24"] #256 ip addresses  
}

resource "azurerm_subnet" "subnet3" {
    name                        = "AppSubnet"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.10.2.0/24"] #256 ip addresses  
}

resource "azurerm_subnet" "subnet4" {
    name                        = "InfraSubnet"
    virtual_network_name        = azurerm_virtual_network.myvnet.name 
    resource_group_name         = azurerm_resource_group.myrg.name
    address_prefixes            = ["10.10.3.0/24"] #256 ip addresses  
}