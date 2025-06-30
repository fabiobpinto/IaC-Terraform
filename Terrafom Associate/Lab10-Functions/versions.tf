# Settings Block
terraform {
  backend "azurerm" {
    # resource_group_name  = "rg-acme-state-remote"
    storage_account_name = "stterraform0backend"
    container_name       = "terraform"
    key                  = "terraform2.tfstate"
    access_key           = "S8cpNRx74jkauiJplP+rpZ5B+Eg+mVXaFN7vT9ToC0e+q05pnMhfAg41moJe8Hy4G0586j0CzCm9+AStriDrDw=="
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