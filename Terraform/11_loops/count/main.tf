# 1 Resource Group      azurerm_resource_group          
# 1 VNET                azurerm_virtual_network
# 3 Subnet
# 3 Network Interface Card
# 3 VM

resource "azurerm_resource_group" "rg1" {
  name      = var.rg_name
  location  = var.rg_location

  lifecycle {
    create_before_destroy = true      #destroy and then create replacement
  }
  
}

resource "azurerm_virtual_network" "vnet1" {
  name                  = var.vnet_name
  address_space         = var.address_space
  resource_group_name   = "countRG"
  location              = "eastus"

  depends_on = [ azurerm_resource_group.rg1 ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_subnet" "subnet" {
  count                 = length(var.subnet_name)       #== 3
  name                  = var.subnet_name[count.index]  #var.subnet_name[0]=subnet1, var.subnet_name[1]=subnet2, var.subnet_name[2]=subnet3
  virtual_network_name  = "countVNET"
  resource_group_name   = "countRG"
  address_prefixes      = ["10.30.${count.index}.0/24"]  # 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24

  depends_on = [ 
    azurerm_resource_group.rg1,
    azurerm_virtual_network.vnet1 
    ]
  lifecycle {
    create_before_destroy = true
  }
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

  lifecycle {
    create_before_destroy = true
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
    public_key = file("C:/Class_Code/T33/Terraform/11_loops/count/SSH_Keys/id_rsa.pub")
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

  depends_on = [ 
    azurerm_resource_group.rg1,
    azurerm_virtual_network.vnet1,
    azurerm_subnet.subnet,
    azurerm_network_interface.nic
   ]

   lifecycle {
    create_before_destroy = true
  }
}