variable "rg_name"{
   type = string
   description = "Name of the resource group"
}

variable "rg_location"{
   type = string
   description = "Location of the resource group"
}

variable "acr_name"{
   type = string
   description = "Name of the Azure Container Registry"
}

variable "acr_sku"{
   type = string
   description = "SKU of the Azure Container Registry"
}

variable "aks_name"{
   type = string
   description = "Name of the Azure Kubernetes Service cluster"
}

variable "aks_dns_prefix"{
   type = string
   description = "DNS prefix for the Azure Kubernetes Service cluster"   
}

variable "aks_node_count"{
   type = number
   description = "Number of nodes in the default node pool of the Azure Kubernetes Service cluster"
}

variable "aks_node_vm_size"{
   type = string
   description = "VM size for the nodes in the default node pool of the Azure Kubernetes Service cluster"
}

variable "aks_env"{
   type = string
   description = "Environment for the Azure Kubernetes Service cluster"
}