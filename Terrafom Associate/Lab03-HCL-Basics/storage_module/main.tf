#Data Block - Import Resource Group do Azure Portal
data "azurerm_resource_group" "rg-azure-terraform" {
    name     = "rg-acme-data-portal"
}

#Variables Locals Block
# Definindo variáveis locais para o módulo
locals {
    storage_account_sku = "Standard"
}

# Variables Block
# Definindo variáveis para o módulo
variable "account_replication_type" {
    description = "Tipo de Replicação do Storage Account"
    default     = "LRS"
    type        = string
}

# Terraform Resource Block - Criação do Storage Account
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

# Terraform Output Values Block
output "storage_account_id" {
    value = azurerm_storage_account.storage_account.id
}

# Terraform Output Values Block
output "storage_account_name" {
    value = azurerm_storage_account.storage_account.name
}