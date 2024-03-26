terraform {
  backend "azurerm" {
    resource_group_name  = "terraformstate"
    storage_account_name = "tfstagetreinamentoterra"
    container_name       = "terraformstate"
    key                  = ""
  }
}

provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {
  }
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "appservice_rg" {
  name     = "appservice_rg_${lower(terraform.workspace)}"
  location = var.location
}

resource "azurerm_service_plan" "serviceplan" {
  name                = "serviceplan_${lower(terraform.workspace)}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = "app-terraform-fabio-${lower(terraform.workspace)}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.serviceplan.id

  site_config {
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "chave" = "123456"
  }

}


