provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {
  }
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "rgappserviceslot" {
  name     = "RG-AppService-Slots"
  location = var.location
}

resource "azurerm_service_plan" "serviceplan" {
  name                = "appplan-slots"
  resource_group_name = azurerm_resource_group.rgappserviceslot.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}


resource "azurerm_linux_web_app" "webapp" {
  name                = "pitocco-web-app"
  resource_group_name = azurerm_resource_group.rgappserviceslot.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.serviceplan.id

  site_config {
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "chave" = "123456"
  }
}

resource "azurerm_linux_web_app_slot" "webappslot" {
  name           = "webappslot"
  app_service_id = azurerm_linux_web_app.webapp.id
  site_config {}
}



# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot