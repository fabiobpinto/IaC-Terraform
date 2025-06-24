# Coleta de dados do Key Vault
data "azurerm_key_vault" "kv-acme" {
  name                = "kv-acme-01"
  resource_group_name = "rg-acme-kv"
}

data "azurerm_key_vault_secret" "kv-acme-secret" {
  name         = "acme-secret"
  key_vault_id = data.azurerm_key_vault.kv-acme.id
}

resource "azurerm_resource_group" "rg_acme_win" {
  name     = var.rg_name_win
  location = var.location_win
}

resource "azurerm_network_security_group" "nsg_acme_win" {
  name                = var.nsg_acme_win_name
  location            = azurerm_resource_group.rg_acme_win.location
  resource_group_name = azurerm_resource_group.rg_acme_win.name
}

resource "azurerm_network_security_rule" "nsg_rules_win" {
  for_each                    = { for rule in var.nsg_rules_win : rule.name => rule }
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg_acme_win.name
  network_security_group_name = azurerm_network_security_group.nsg_acme_win.name
}



resource "azurerm_virtual_network" "vnet_acme_win" {
  name                = var.vnet_name_win
  address_space       = var.vnet_address_space_win
  location            = azurerm_resource_group.rg_acme_win.location
  resource_group_name = azurerm_resource_group.rg_acme_win.name
}

resource "azurerm_subnet" "subnet_acme_win" {
  count                = length(var.subnet_cidr_win)
  name                 = "${var.subnet_name_win}-${count.index}"
  resource_group_name  = azurerm_resource_group.rg_acme_win.name
  virtual_network_name = azurerm_virtual_network.vnet_acme_win.name
  address_prefixes     = [var.subnet_prefixes_win[count.index]]
}

resource "azurerm_subnet_network_security_group_association" "nsg_acme_subnet_win" {
  count                     = length(azurerm_subnet.subnet_acme_win)
  subnet_id                 = azurerm_subnet.subnet_acme_win[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg_acme_win.id
}

resource "azurerm_public_ip" "pip_acme_win" {
  name                = var.pip_name_win
  resource_group_name = azurerm_resource_group.rg_acme_win.name
  location            = azurerm_resource_group.rg_acme_win.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic_acme_win" {
  name                = var.nic_acme_win_name
  location            = azurerm_resource_group.rg_acme_win.location
  resource_group_name = azurerm_resource_group.rg_acme_win.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.subnet_acme_win[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_acme_win.id
  }

}

resource "azurerm_windows_virtual_machine" "vm_win" {
  name                = var.vm_name_win
  resource_group_name = azurerm_resource_group.rg_acme_win.name
  location            = azurerm_resource_group.rg_acme_win.location
  size                = var.vm_size_win
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.kv-acme-secret.value
  network_interface_ids = [
    azurerm_network_interface.nic_acme_win.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = var.tags_win

}

resource "azurerm_managed_disk" "data_disks" {
  for_each             = { for idx, size in var.data_disk_sizes_win : idx => size }
  name                 = "${var.vm_name_win}-datadisk-${each.key + 1}"
  location             = azurerm_resource_group.rg_acme_win.location
  resource_group_name  = azurerm_resource_group.rg_acme_win.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = each.value
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_disks" {
  for_each            = azurerm_managed_disk.data_disks
  managed_disk_id     = each.value.id
  virtual_machine_id  = azurerm_windows_virtual_machine.vm_win.id
  lun                 = tonumber(regex("[0-9]+$", each.key)) + 1
  caching             = "ReadWrite"
}