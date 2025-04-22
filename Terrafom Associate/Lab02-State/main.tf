# Create Resource Group
resource "azurerm_resource_group" "rg-acme" {
  name     = "rg-acme-from-terraform"
  location = "eastus"
}

# Create Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet-acme" {
  name                = "vnet-acme-from-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-acme.location
  resource_group_name = azurerm_resource_group.rg-acme.name
}

# Create subnet 01 on VNet
resource "azurerm_subnet" "sub-acme01" {
  name                 = "sub-acme01-from-terraform"
  resource_group_name  = azurerm_resource_group.rg-acme.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet-acme.name
}

# Create subnet 02 on VNet
resource "azurerm_subnet" "sub-acme02" {
  name                 = "sub-acme02-from-terraform"
  resource_group_name  = azurerm_resource_group.rg-acme.name
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet-acme.name
}

# Create subnet 03 on VNet
resource "azurerm_subnet" "sub-acme03" {
  name                 = "sub-acme03-from-terraform"
  resource_group_name  = azurerm_resource_group.rg-acme.name
  address_prefixes     = ["10.0.3.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet-acme.name
}

# Create Network Security Group (NSG)
resource "azurerm_network_security_group" "nsg-acme" {
  name                = "nsg-acme-from-terraform"
  location            = azurerm_resource_group.rg-acme.location
  resource_group_name = azurerm_resource_group.rg-acme.name

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
}

# Create Public IP
resource "azurerm_public_ip" "pip-acme" {
  name                = "pip-acme-from-terraform"
  location            = azurerm_resource_group.rg-acme.location
  resource_group_name = azurerm_resource_group.rg-acme.name
  allocation_method   = "Static"
}

# Create Network Internface
resource "azurerm_network_interface" "nic-acme" {
  name                = "nic-acme-from-terraform"
  location            = azurerm_resource_group.rg-acme.location
  resource_group_name = azurerm_resource_group.rg-acme.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub-acme01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-acme.id
  }
}

# Create Virtual Machine Linux
resource "azurerm_virtual_machine" "vm-acme" {
  name                  = "vm-acme-from-terraform"
  location              = azurerm_resource_group.rg-acme.location
  resource_group_name   = azurerm_resource_group.rg-acme.name
  network_interface_ids = [azurerm_network_interface.nic-acme.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-acme-from-terraform"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "acmeprime"
    admin_username = "adminuser"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  delete_os_disk_on_termination = true

  tags = {
    environment = "acme"
    provisioner = "terraform"
    aula01      = "nova tag"
  }
}