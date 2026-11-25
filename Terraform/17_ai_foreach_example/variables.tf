variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for all resources."
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources."
  default     = {}
}

variable "virtual_machines" {
  description = "Map of virtual machines to create. Key is used as the VM identifier."
  type = map(object({
    name           = string
    vm_size        = string
    os_type        = string # linux or windows
    computer_name  = optional(string)
    admin_username = string
    admin_password = string
    zone           = optional(string)

    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = optional(number)
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))

  validation {
    condition = alltrue([
      for vm in values(var.virtual_machines) : contains(["linux", "windows"], lower(vm.os_type))
    ])
    error_message = "Each virtual_machines entry must set os_type to either \"linux\" or \"windows\"."
  }
}
