provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {
  }
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "website" {
  name     = "WebSite"
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                      = "websitestatico1302"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.website.name
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "website_files" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "index.html"
  content_type           = "text/html"
}