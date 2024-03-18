terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"
  features {}
  alias = "VSCodeProfessional"
}

resource "azurerm_resource_group" "rg_terraform" {
  count    = 2
  location = "eastus"
  name     = "rg-terraform-${count.index}"
  provider = azurerm.VSCodeProfessional
  tags = {
    data        = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    ambiente    = lower("Homologacao")
    responsavel = upper("Fabio Brito")
    tecnologia  = title("hashicorp terraform")
  }
}

variable "vnetips" {
  type    = list(any)
  default = ["192.168.100.0/24"]

}
resource "azurerm_virtual_network" "vnet_qas" {
  provider            = azurerm.VSCodeProfessional
  name                = "vnet-qas"
  resource_group_name = "rg-terraform-1"
  location            = "eastus"
  address_space       = length(var.vnetips) == 0 ? ["10.0.0.0/16", "192.168.0.0/16"] : var.vnetips
  depends_on = [
    azurerm_resource_group.rg_terraform
  ]
}

output "vnet_num_address_space" {
  value = length("${azurerm_virtual_network.vnet_qas.address_space}")
}