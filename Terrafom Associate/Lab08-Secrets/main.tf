terraform {
  backend "azurerm" {
    # O conteudo do arquivo backend_state.hcl poderia estar todo aqui
    # para chamar o backend do terraform damos o comando:
    # terraform init -backend-config=backend_state.hcl
  }
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

################################################################################
module "storage_module" {
  source = "./storage_module"
}
#Terraform Output Values Block - Block Storage
output "storage_account_id" {
  value = module.storage_module.storage_account_id
}
output "storage_account_name" {
  value = module.storage_module.storage_account_name
}
################################################################################
module "rg_import_module" {
  source = "./resource_group"
}
################################################################################
module "dns_zone_module" {
  source   = "./dns_zone"
  dns_name = "acme.com"
  rg_name  = module.rg_import_module.rg_name_import
}

#Terraform Output Values Block - Block DNS
output "dns_id" {
  value = module.dns_zone_module.dns_id
}

################################################################################
#module Terraform Registry
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["acme"]
}

################################################################################
# Modulo SQL Server
module "sql_module" {
  source                       = "./sql_server"
  sql_name                     = var.sql_name
  rg_name                      = module.rg_import_module.rg_name_import
  rg_location                  = var.sql_location
  sql_version                  = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}


resource "azurerm_resource_group" "rg_01" {
  name     = module.naming.resource_group.name_unique
  location = "East US"
}

output "rg_01_name" {
  value = azurerm_resource_group.rg_01.name

}