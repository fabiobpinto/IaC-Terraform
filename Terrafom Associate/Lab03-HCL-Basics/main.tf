# 01 - Criar o Terraform Settings Block
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

# 08 - Criar o Terraform Modules Block - Utilização do Módulo
module "storage_module" {
  source = "./storage_module"
}

# 07 - Criar o Terraform Output Values Block
output "storage_account_id" {
  value = module.storage_module.storage_account_id
}
output "storage_account_name" {
  value = module.storage_module.storage_account_name
}