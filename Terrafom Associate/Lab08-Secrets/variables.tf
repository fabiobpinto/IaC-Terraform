variable "sql_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_location" {
  description = "The location of the SQL Server"
  type        = string
}

variable "sql_version" {
  description = "The version of the SQL Server"
  type        = string
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server"
  type        = string
  sensitive   = true
}
variable "administrator_login_password" {
  description = "The password for the administrator login"
  type        = string
  sensitive   = true
}