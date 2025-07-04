# Settings Block
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "stterraform0backend"
    container_name       = "terraform"
    key                  = "terraform2.tfstate"
    access_key           = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}