output "secret_value" {
  value = data.azurerm_key_vault_secret.kv-acme-secret.value
  sensitive = true
}


output "public_ip_address" {
  value = azurerm_public_ip.pip-linux-01.ip_address
}
