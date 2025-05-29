

module "vm-linux-01" {
  source = "./vm-linux-01"

  rg_name        = var.rg_name
  rg_location    = var.rg_location
  nsg_name       = var.nsg_name
  vnet_name      = var.vnet_name
  vnet_cidr      = var.vnet_cidr
  subnet_name    = var.subnet_name
  snet_cidr      = var.subnet_cidr
  pip_name       = var.pip_name
  nic_linux_name = var.nic_linux_name
  vm_name        = var.vm_name
  vm_username    = var.vm_username
  vm_sku         = var.vm_sku

}