terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
    randon = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

module "storage_module" {
  source = "./storage_module"
}

#Terraform Output Values Block
output "storage_account_id" {
  value = module.storage_module.storage_account_id
}
output "storage_account_name" {
  value = module.storage_module.storage_account_name
}

module "rg_import_module" {
  source = "./resource_group"
}

# module "pip_import_module" {
#   source = "./public_ip"
# }