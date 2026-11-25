resource_group_name = "rg-vm-foreach-demo"
location            = "eastus"

vnet_name               = "vnet-vm-foreach-demo"
vnet_address_space      = ["10.30.0.0/16"]
subnet_name             = "snet-vm-foreach-demo"
subnet_address_prefixes = ["10.30.1.0/24"]

tags = {
  environment = "demo"
  managed_by  = "terraform"
}

virtual_machines = {
  ubuntu = {
    name           = "vm-ubuntu2204"
    vm_size        = "Standard_B2s"
    os_type        = "linux"
    computer_name  = "ubuntu2204"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd1234!" # Replace before use

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 64
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }

  windows = {
    name           = "vm-win2022"
    vm_size        = "Standard_B2s"
    os_type        = "windows"
    computer_name  = "win2022"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd1234!" # Replace before use

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 128
    }

    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter-g2"
      version   = "latest"
    }
  }
}
