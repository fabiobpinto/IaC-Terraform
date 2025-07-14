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

resource "azurerm_resource_group" "rg_strings" {
  name     = "rg-date"
  provider = azurerm.VSCodeProfessional
  location = "eastus"
  tags = {
    Env      = upper("qas")
    Software = lower("TerraForm")
    Autor    = title("fabio brito")
  }
}

## https://developer.hashicorp.com/terraform/language/functions/lower