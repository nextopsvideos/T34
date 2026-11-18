# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.14.0"   #12 days old
    }
  }
}

provider "azurerm" {
  features {}  
}