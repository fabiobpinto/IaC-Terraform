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
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {}
}

resource "random_string" "random" {
  length  = 2
  special = false
  upper   = false
  lower   = true
  numeric = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "RG-KeyVault"
  location = "eastus"
}

resource "azurerm_key_vault" "keyvault" {
  resource_group_name        = azurerm_resource_group.rg.name
  name                       = "keyvaultcloudterraformnv"
  location                   = azurerm_resource_group.rg.location
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7

  access_policy {
    key_permissions = ["Create", "Get", "List"]
    object_id       = data.azurerm_client_config.current.object_id
    tenant_id       = data.azurerm_client_config.current.tenant_id
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List"
    ]
    certificate_permissions = [
      "List"
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name            = "secret"
  value           = "meusegredo@abc123"
  key_vault_id    = azurerm_key_vault.keyvault.id
  expiration_date = "2024-04-15T00:00:00Z" #  (Y-m-d'T'H:M:S'Z')
}

data "azurerm_key_vault_secret" "getsecret" {
  name         = "secret"
  key_vault_id = azurerm_key_vault.keyvault.id

}

output "secret_value" {
  value     = data.azurerm_key_vault_secret.getsecret.value
  sensitive = true
}

output "secret_url" {
  value = azurerm_key_vault.keyvault.vault_uri
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
