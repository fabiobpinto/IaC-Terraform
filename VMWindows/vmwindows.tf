provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  features {
  }
}

resource "azurerm_resource_group" "rgvm" {
  name     = "RGVM-Windows"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "Vnet"
  location            = azurerm_resource_group.rgvm.location
  resource_group_name = azurerm_resource_group.rgvm.name
  address_space       = ["10.0.0.0/16", "192.168.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgvm.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgvm.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-Windows"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location
  allocation_method   = "Static"
  domain_name_label   = "winserverterracloud"
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "nicwindows" {
  name                = "nicwindows"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location
  ip_configuration {
    name                          = "nic-config"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

variable "regras_entrada" {
  type = map(any)
  default = {
    500 = 80
    501 = 443
    502 = 1500
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-windows"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location

  dynamic "security_rule" {
    for_each = var.regras_entrada
    content {
      name                       = "Allow-${security_rule.value}"
      priority                   = security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet" {
  network_security_group_id = azurerm_network_security_group.nsg.id
  subnet_id                 = azurerm_subnet.subnet1.id
}


resource "azurerm_windows_virtual_machine" "vmwindows" {
  name                = "WindowsServer"
  resource_group_name = azurerm_resource_group.rgvm.name
  location            = azurerm_resource_group.rgvm.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nicwindows.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}






# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine