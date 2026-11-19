#1 resource group
#1 virtual network
#3 subnets
#3 network interfaces
#3 virtual machines

resource "azurerm_resource_group" "rg1" {
    name      = var.rg_name
    location  = var.rg_location  
}

resource "azurerm_virtual_network" "vnet1" {
  name                  = var.vnet_name
  address_space         = var.address_space
  resource_group_name   = azurerm_resource_group.rg1.name
  location              = azurerm_resource_group.rg1.location
}

resource "azurerm_subnet" "subnet" {
    count                = length(var.subnet_name)  #3
    name                 = var.subnet_name[count.index] #0=subnet1, 1=subnet2, 2=subnet3
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name  = azurerm_resource_group.rg1.name
    address_prefixes     = ["10.30.${count.index}.0/24"] #10.30.0.0/24, 10.30.1.0/24, 10.30.2.0/24
}


resource "azurerm_network_interface" "nic" {
  count                     = 3                         
  name                      = "nextopsnic-${count.index}" #nextopsnic-0, nextopsnic-1, nextopsnic-2
  location                  = azurerm_resource_group.rg1.location
  resource_group_name       = azurerm_resource_group.rg1.name 

  ip_configuration {
    name                            = "internal"
    subnet_id                       = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation   = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.subnet_name) #3
  name                = "nextopsvm${count.index}" #nextopsvm0, nextopsvm1, nextopsvm2, #nextopsvm3
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    #ssh-keygen -t rsa -f C:\Class_Code\T33\Terraform\11_loops\count\SSH_Keys\id_rsa 
    public_key = file("D:/Class_Code/T34/Terraform/11_loops/count/SSH_Keys/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}