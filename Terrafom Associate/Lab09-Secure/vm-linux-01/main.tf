# Coleta de dados do Key Vault
data "azurerm_key_vault" "kv-acme" {
  name                = "kv-acme-01"
  resource_group_name = "rg-acme-kv"
}

data "azurerm_key_vault_secret" "kv-acme-secret" {
  name         = "acme-secret"
  key_vault_id = data.azurerm_key_vault.kv-acme.id
}


# Configuração da Rede, NSG, VNet, Subnet, Public IP e NIC

resource "azurerm_resource_group" "rg-acme-lnx" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_network_security_group" "nsg-acme-lnx" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg-acme-lnx.location
  resource_group_name = azurerm_resource_group.rg-acme-lnx.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet-acme-lnx" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.rg-acme-lnx.location
  resource_group_name = azurerm_resource_group.rg-acme-lnx.name
}

resource "azurerm_subnet" "subnet-acme-lnx" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg-acme-lnx.name
  virtual_network_name = azurerm_virtual_network.vnet-acme-lnx.name
  address_prefixes     = var.snet_cidr
}

resource "azurerm_public_ip" "pip-linux-01" {
  name                = var.pip_name
  location            = azurerm_resource_group.rg-acme-lnx.location
  resource_group_name = azurerm_resource_group.rg-acme-lnx.name
  allocation_method   = "Static"

}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.subnet-acme-lnx.id
  network_security_group_id = azurerm_network_security_group.nsg-acme-lnx.id
}


resource "azurerm_network_interface" "nic-linux-01" {
  name                = var.nic_linux_name
  location            = azurerm_resource_group.rg-acme-lnx.location
  resource_group_name = azurerm_resource_group.rg-acme-lnx.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.subnet-acme-lnx.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-linux-01.id
  }
}

#Virtual Machine
resource "azurerm_linux_virtual_machine" "vm-linux-01" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.rg-acme-lnx.name
  location            = azurerm_resource_group.rg-acme-lnx.location
  size                = var.vm_sku
  admin_username      = var.vm_username
  admin_password      = data.azurerm_key_vault_secret.kv-acme-secret.value
  network_interface_ids = [
    azurerm_network_interface.nic-linux-01.id,
  ]

    disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}