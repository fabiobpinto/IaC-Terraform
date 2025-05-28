resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_name
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}