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
  alias = "VSCodeDev"
}

provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {}
  alias = "VSCodeProfessional"
}

resource "azurerm_resource_group" "rg-vscode" {
  name     = "RG-VSCode"
  location = "brazilsouth"
  provider = azurerm.VSCodeProfessional
  tags = {
    Env      = "QAS"
    Software = "Terraform"
  }
}