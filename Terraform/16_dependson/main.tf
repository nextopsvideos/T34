
resource "azurerm_resource_group" "myrg" {
    name        = "NextOpsRGT34"
    location    = "eastus"
}

resource "azurerm_virtual_network" "myvnet" {
    name                = "NextOpsVNETT34"
    location            = "eastus"
    resource_group_name = "NextOpsRGT34"
    address_space       = ["10.10.0.0/16"]     

    depends_on = [ azurerm_resource_group.myrg ]
}

resource "azurerm_subnet" "subnet1" {
    name                        = "WebSubnet"
    virtual_network_name        = "NextOpsVNETT34"
    resource_group_name         = "NextOpsRGT34"
    address_prefixes            = ["10.10.0.0/24"]

    depends_on = [ 
        azurerm_resource_group.myrg,
        azurerm_virtual_network.myvnet 
    ]
}