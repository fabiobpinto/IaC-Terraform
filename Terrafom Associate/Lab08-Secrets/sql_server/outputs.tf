output "sql_password" {
  value     = azurerm_mssql_server.sql_server.administrator_login_password
  sensitive = true
}

output "sql_admin" {
  value     = azurerm_mssql_server.sql_server.administrator_login
  sensitive = true

}