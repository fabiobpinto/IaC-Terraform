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

resource "azurerm_resource_group" "rg_date" {
  name     = "rg_date"
  provider = azurerm.VSCodeProfessional
  location = "eastus"
  tags = {
    Data     = formatdate("DD/MMM/YYYY-hh:mm", timestamp())
    Autor    = "Fabio Brito"
  }
}

# https://developer.hashicorp.com/terraform/language/functions/formatdate