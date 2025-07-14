provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {
  }
}


resource "azurerm_resource_group" "rg" {
  name     = "RG-Terraform-Import"
  location = "eastus"
  tags = {
    Owner = "Fabio Brito"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-import"
  resource_group_name = "RG-Terraform-Import"
  location            = "eastus"
  address_space       = ["10.0.0.0/16", "10.10.0.0/16"]
  tags = {
    Owner = "Fabio"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-import"
  location            = "eastus"
  resource_group_name = "RG-Terraform-Import"
  tags = {
    Resource = "Network"
  }
}

resource "azurerm_network_security_rule" "rule" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "AllowAnyHTTPInbound"
  priority                    = 1000
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  network_security_group_name = "nsg-import"
  resource_group_name         = "RG-Terraform-Import"

}