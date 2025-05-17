data "azurerm_resource_group" "rg-acme-data-portal" {
  name = "rg-acme-data-portal"
}

locals {
  storage_account_sku = "Standard"
}

variable "account_replication_type" {
  description = "Tipo de Replicação do Storage Account"
  default     = "LRS"
  type        = string
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
  numeric  = true
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "stacme${random_string.random.result}"
  resource_group_name      = data.azurerm_resource_group.rg-acme-data-portal.name
  location                 = data.azurerm_resource_group.rg-acme-data-portal.location
  account_tier             = local.storage_account_sku
  account_replication_type = var.account_replication_type
  tags = {
    environment = "dev"
    project     = "terraform"
  }
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}

# Terraform Output Values Block
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}