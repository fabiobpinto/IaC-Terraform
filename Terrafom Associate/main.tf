terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "c30c5829-2a81-4982-8141-09566ee674d6"
  features {}
  alias = "VSCodeDev"
}

resource "azurerm_resource_group" "rg-vscode" {
  name     = "RG-VSCode"
  location = "brazilsouth"
  provider = azurerm.VSCodeDev
  tags = {
    Env      = "QAS"
    Software = "Terraform"
  }
}