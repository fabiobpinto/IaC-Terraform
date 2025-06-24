module "mod_vm_win" {
  source                 = "./modules/vm-windows"
  data_disk_sizes_win    = var.data_disk_sizes_win
  location_win           = var.location_win
  nic_acme_win_name      = var.nic_acme_win_name
  nsg_acme_win_name      = var.nsg_acme_win_name
  nsg_rules_win          = var.nsg_rules_win
  pip_name_win           = var.pip_name_win
  rg_name_win            = var.rg_name_win
  subnet_cidr_win        = var.subnet_cidr_win
  subnet_name_win        = var.subnet_name_win
  subnet_prefixes_win    = var.subnet_prefixes_win
  tags_win               = var.tags_win
  vm_name_win            = var.vm_name_win
  vm_size_win            = var.vm_size_win
  vnet_address_space_win = var.vnet_address_space_win
  vnet_name_win          = var.vnet_name_win
}