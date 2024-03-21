terraform {
  backend "azurerm" {
    resource_group_name  = "terraformstate"
    subscription_id      = "ff882453-92d9-4cdd-a627-966b0727aeec"
    storage_account_name = "terraformstatecloud"
    container_name       = "terraformstate"
    key                  = "" #Sua Key do Storage Account > Access Keys
  }
}

provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {}
  alias = "VSCodeProfessional"
}

resource "azurerm_resource_group" "rg_state" {
  name     = "RG_Terraform_State"
  location = "eastus"
  provider = azurerm.VSCodeProfessional
}