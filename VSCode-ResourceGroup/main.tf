terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "c30c5829-2a81-4982-8141-09566ee674d6"
  features {}
  alias = "VSCodeDev"
}

provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
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