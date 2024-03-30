provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {}
}

data "azurerm_key_vault" "getkeyvault" {
  name = "keyvaultcloudterraformnv"
  resource_group_name = "RG-KeyVault"
}

data "azurerm_key_vault_secret" "getsecret" {
  name = "secret"
  key_vault_id = azurerm_key_vault.getkeyvault.id
  
}

output "secret" {
    value = data.azurerm_key_vault_secret.getkeyvault.value
}