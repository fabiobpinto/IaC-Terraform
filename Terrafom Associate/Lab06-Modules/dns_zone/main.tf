#01 - Criar bloco de resource de DNS
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_name
  resource_group_name = var.rg_name
}
