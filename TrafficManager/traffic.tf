provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {
  }
}

resource "azurerm_resource_group" "rgtrafficmanager" {
  name     = "RG-Traffic-Manager"
  location = "eastus"
}

resource "azurerm_traffic_manager_profile" "traffic_profile" {
  name                   = "trafficmanagergeo1302"
  resource_group_name    = azurerm_resource_group.rgtrafficmanager.name
  traffic_routing_method = "Geographic" # Geographic, Weighted, Performance, Priority, Subnet e MultiValue

  dns_config {
    relative_name = "trafficmanagergeo1302"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}


#######################################################################################
#### Brasil
#######################################################################################
resource "azurerm_service_plan" "serviceplanbr" {
  name                = "appplanbr"
  resource_group_name = azurerm_resource_group.rgtrafficmanager.name
  location            = "brazilsouth"
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "webappbr" {
  name                = "pitocco-web-appbr"
  resource_group_name = azurerm_resource_group.rgtrafficmanager.name
  location            = "brazilsouth"
  service_plan_id     = azurerm_service_plan.serviceplanbr.id

  site_config {
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "chave" = "123456"
  }
}

#######################################################################################
#### EUA
#######################################################################################
resource "azurerm_service_plan" "serviceplanusa" {
  name                = "appplanusaa"
  resource_group_name = azurerm_resource_group.rgtrafficmanager.name
  location            = "eastus"
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "webappusa" {
  name                = "pitocco-web-appusa"
  resource_group_name = azurerm_resource_group.rgtrafficmanager.name
  location            = "eastus"
  service_plan_id     = azurerm_service_plan.serviceplanusa.id

  site_config {
    minimum_tls_version = "1.2"
  }

  app_settings = {
    "chave" = "123456"
  }
}

# #######################################################################################
# #### Endpoints
# #######################################################################################
resource "azurerm_traffic_manager_azure_endpoint" "traffic_endpointbr" {
  name                 = "trafficendpointbr"
  profile_id           = azurerm_traffic_manager_profile.traffic_profile.id
  always_serve_enabled = true
  weight               = 100
  target_resource_id   = azurerm_linux_web_app.webappbr.id
  geo_mappings = [ "WORLD" ]
}

resource "azurerm_traffic_manager_azure_endpoint" "traffic_endpointusa" {
  name                 = "trafficendpointusa"
  profile_id           = azurerm_traffic_manager_profile.traffic_profile.id
  always_serve_enabled = true
  weight               = 101
  target_resource_id   = azurerm_linux_web_app.webappusa.id
  geo_mappings = [ "US" ]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_profile
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_azure_endpoint