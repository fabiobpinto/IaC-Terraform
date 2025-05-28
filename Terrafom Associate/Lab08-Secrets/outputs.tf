output "sql_password" {
  value     = module.sql_module.sql_password
  sensitive = true
}

output "sql_admin" {
  value     = module.sql_module.sql_admin
  sensitive = true
}