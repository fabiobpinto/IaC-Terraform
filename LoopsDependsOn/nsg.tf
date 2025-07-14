provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {}
}

resource "azurerm_resource_group" "vnet_rg" {
  provider = azurerm.VSCodeProfessional
  name     = "vnet_rg"
  location = "eastus"
}

resource "azurerm_network_security_group" "nsg" {
  provider            = azurerm.VSCodeProfessional
  name                = "nsg"
  resource_group_name = azurerm_resource_group.vnet_rg.name
  location            = azurerm_resource_group.vnet_rg.location
  depends_on = [
    azurerm_resource_group.vnet_rg
  ]
}

variable "portas_input" {
  type        = map(any)
  description = "Lista de portas Liberadas para Entrada"
  default = {
    110 = 80
    120 = 443
    130 = 22
    140 = 3389
  }
}


resource "azurerm_network_security_rule" "regras_inbound" {
  for_each                    = var.portas_input
  resource_group_name         = azurerm_resource_group.vnet_rg.name
  name                        = "PortaEntrada_${each.value}"
  priority                    = each.key
  destination_port_range      = each.value
  direction                   = "Inbound"
  access                      = "Allow"
  source_port_range           = "*"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule