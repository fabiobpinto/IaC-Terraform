terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {}
  alias = "VSCodeProfessional"
}

resource "azurerm_resource_group" "RG-Servers" {
  provider = azurerm.VSCodeProfessional
  name     = var.namerg
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  provider = azurerm.VSCodeProfessional
  name                = "vnet"
  resource_group_name = azurerm_resource_group.RG-Servers.name
  location            = azurerm_resource_group.RG-Servers.location
  address_space       = var.address_space
}
