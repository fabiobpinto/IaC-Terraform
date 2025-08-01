terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {}
  alias = "VSCodeProfessional"
}

variable "vnet-ips" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

resource "azurerm_resource_group" "rg_vnet" {
  name     = "rg_vnet"
  provider = azurerm.VSCodeProfessional
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  provider            = azurerm.VSCodeProfessional
  name                = "vnet"
  resource_group_name = "rg_vnet"
  location            = "eastus"
  address_space       = concat(var.vnet-ips, ["172.10.0.0/16"])
}

output "vnets-ips" {
  value = length("${azurerm_virtual_network.vnet.address_space}")
}

# https://developer.hashicorp.com/terraform/language/functions/concat