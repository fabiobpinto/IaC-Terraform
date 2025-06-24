variable "rg_name_win" {
  description = "Name of the resource group for Windows VM"
  type        = string
}
variable "location_win" {
  description = "Location for the Windows VM resources"
  type        = string
}
variable "nsg_acme_win_name" {
  description = "Name of the Network Security Group for Windows VM"
  type        = string
}
variable "nsg_rules_win" {
  description = "List of security rules for the Network Security Group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "vnet_name_win" {
  description = "Name of the Virtual Network for Windows VM"
  type        = string
}
variable "vnet_address_space_win" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}
variable "subnet_name_win" {
  description = "Base name for the subnets in the Virtual Network"
  type        = string
}
variable "subnet_cidr_win" {
  description = "CIDR blocks for the subnets in the Virtual Network"
  type        = list(string)
}
variable "subnet_prefixes_win" {
  description = "Address prefixes for the subnets in the Virtual Network"
  type        = list(string)
}
variable "pip_name_win" {
  description = "Name of the Public IP for Windows VM"
  type        = string
}
variable "nic_acme_win_name" {
  description = "Name of the Network Interface for Windows VM"
  type        = string
}
variable "vm_name_win" {
  description = "Name of the Windows Virtual Machine"
  type        = string
}
variable "vm_size_win" {
  description = "Size of the Windows Virtual Machine"
  type        = string
  default     = "Standard_DS1_v2"
}
variable "data_disk_sizes_win" {
  description = "List of data disk sizes for the Windows Virtual Machine"
  type        = tuple([number, number])
  default     = [128, 256]
}
variable "tags_win" {
  description = "Tags to apply to the Windows VM resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "acme"
    owner       = "admin"
  }

}