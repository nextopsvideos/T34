# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.14.0"   #12 days old
    }
  }

  backend "azurerm" {
    access_key           = "siasadafddfdadfdfafadfdfadf"  # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "nextopssat34"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}  
}