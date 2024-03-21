terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}


provider "azurerm" {
  features {}
}


provider "random" {
}

resource "azurerm_resource_group" "rg_storage_terraform" {
  name     = "RG_Storage"
  location = "eastus"

}

resource "random_string" "random_text" {
  length  = 5
  special = false
  numeric = false
  lower   = true
  upper   = false
}

resource "azurerm_storage_account" "storage_account_terraform" {
  name                     = "terraformcloud${random_string.random_text.result}"
  resource_group_name      = azurerm_resource_group.rg_storage_terraform.name
  location                 = "eastus"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  access_tier              = "Hot"
}


resource "azurerm_storage_container" "container" {
  name                 = "arquivos"
  storage_account_name = azurerm_storage_account.storage_account_terraform.name
  depends_on           = [azurerm_storage_account.storage_account_terraform]
}


output "nome_storage" {
  value = azurerm_storage_account.storage_account_terraform.name

}

output "primary_key_storage" {
  value = azurerm_storage_account.storage_account_terraform.primary_access_key
  sensitive = true
}

output "primary_connection_storage" {
  value = azurerm_storage_account.storage_account_terraform.primary_connection_string
  sensitive = true
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container