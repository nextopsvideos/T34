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

  client_id       = "af5fedfe-ebcd-4d9a-bbba-a37ee945f031"
  client_secret   = "9B38Q~.46hDyGmVJCTzm0VMqi669EFYoM8zugciz"
  tenant_id       = "9085ff8c-8807-4ff8-a403-ea470525cda6"
  subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"
  
}