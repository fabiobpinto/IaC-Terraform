data "azurerm_key_vault" "kv-acme" {
  name                = "kv-acme-01"
  resource_group_name = "rg-acme-kv"
}

data "azurerm_key_vault_secret" "kv-acme-secret" {
  name         = "acme-secret"
  key_vault_id = data.azurerm_key_vault.kv-acme.id
}

resource "azurerm_resource_group" "rg_acme_linux" {
  name     = var.rg_name
  location = var.rg_location
}


resource "azurerm_network_security_group" "nsg_linux" {
  name                = var.nsg_linux_name
  location            = azurerm_resource_group.rg_acme_linux.location
  resource_group_name = azurerm_resource_group.rg_acme_linux.name
}

resource "azurerm_network_security_rule" "nsg_rules_linux" {
  for_each                    = { for rule in var.nsg_rules_linux : rule.name => rule }
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg_acme_linux.name
  network_security_group_name = azurerm_network_security_group.nsg_linux.name
}

resource "azurerm_virtual_network" "vnet_acme_linux" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg_acme_linux.location
  resource_group_name = azurerm_resource_group.rg_acme_linux.name
}

resource "azurerm_subnet" "subnet_acme_linux" {
  for_each             = toset(var.subnet_names)
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg_acme_linux.name
  virtual_network_name = azurerm_virtual_network.vnet_acme_linux.name
  address_prefixes     = ["10.0.${(each.value == "snet-01") ? 1 : 2}.0/24"] # Exemplo de uso de lógica condicional, se for "snet-01", o prefixo será "1", caso contrário, será "2"
  #   address_prefixes     = [each.value]
}

resource "azurerm_subnet_network_security_group_association" "nsg_acme_linux_association" {
  for_each                  = azurerm_subnet.subnet_acme_linux
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg_linux.id
}


resource "azurerm_public_ip" "pip_linux" {
  count               = var.vm_qtd
  name                = "${var.pip_name_linux}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg_acme_linux.name
  location            = azurerm_resource_group.rg_acme_linux.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic_linux" {
  count               = var.vm_qtd
  name                = "${var.nic_linux_name}-${count.index + 1}"
  location            = azurerm_resource_group.rg_acme_linux.location
  resource_group_name = azurerm_resource_group.rg_acme_linux.name

  ip_configuration {
    name                          = "internal-${count.index + 1}"
    subnet_id                     = azurerm_subnet.subnet_acme_linux[var.subnet_names[count.index]].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_linux[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "vm_acme_linux" {
  count                           = var.vm_qtd
  name                            = "${var.vm_linux_name}-${count.index + 1}"
  resource_group_name             = azurerm_resource_group.rg_acme_linux.name
  location                        = azurerm_resource_group.rg_acme_linux.location
  size                            = var.vm_linux_size
  admin_username                  = "adminuser"
  admin_password                  = data.azurerm_key_vault_secret.kv-acme-secret.value
  network_interface_ids           = [azurerm_network_interface.nic_linux[count.index].id]
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

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type     = "ssh"
      user     = "adminuser"
      password = data.azurerm_key_vault_secret.kv-acme-secret.value
      host     = azurerm_public_ip.pip_linux[count.index].ip_address
      timeout  = "5m"
    }

  }

  tags = var.tags_linux
}