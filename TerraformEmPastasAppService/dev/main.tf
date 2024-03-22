# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.95.0"
#     }
#   }
# }


resource "azurerm_resource_group" "appservice_rg" {
  name     = "appservice_rg_${lower(var.ambiente)}"
  location = var.location
}

resource "azurerm_service_plan" "serviceplan" {
  name = "serviceplan_${lower(var.ambiente)}"
  resource_group_name = azurerm_resource_group.appservice_rg.name
  location = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = "app-terraform-fabio-${lower(var.ambiente)}"
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




# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# Depreciado - Usar o azurerm_linux_web_app e azurerm_windows_web_app