module "vm_linux" {
  source             = "./vm-linux"
  rg_name            = var.rg_name
  rg_location        = var.rg_location
  nsg_linux_name     = var.nsg_linux_name
  nsg_rules_linux    = var.nsg_rules_linux
  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnet_names       = var.subnet_names
  vm_qtd             = var.vm_qtd
  pip_name_linux     = var.pip_name_linux
  nic_linux_name     = var.nic_linux_name
  vm_linux_name      = var.vm_linux_name
  vm_linux_size      = var.vm_linux_size
  tags_linux         = var.tags_linux
}