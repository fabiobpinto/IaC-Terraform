# 03 - Criar o Terraform Data Block (Resource Group) - Import do Azure Portal
data "azurerm_resource_group" "rg-azure-terraform" {
  name = "rg-acme-data-portal"
}

# 04 - Criar o Terraform Local Variables Block
locals {
  storage_account_sku = "Standard"
}

# 05 - Criar o Terraform Input Variables Block
variable "account_replication_type" {
  description = "Tipo de Replicação do Storage Account"
  default     = "LRS"
  type        = string
}

# 06 - Criar o Terraform Resource Block (Storage Account) - Criação do Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "stacmepoc"
  resource_group_name      = data.azurerm_resource_group.rg-azure-terraform.name
  location                 = data.azurerm_resource_group.rg-azure-terraform.location
  account_tier             = local.storage_account_sku
  account_replication_type = var.account_replication_type
  tags = {
    environment = "dev"
    project     = "terraform"
  }
}

# 07 - Criar o Terraform Output Values Block
output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}
# Terraform Output Values Block
output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}