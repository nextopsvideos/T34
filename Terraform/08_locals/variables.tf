variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)       #["10.0.0.0/16"]
}


variable "subnet_name" {
  type = string
}

variable "address_prefix" {
  type = list(string)       #["10.0.1.0/24"]
}

