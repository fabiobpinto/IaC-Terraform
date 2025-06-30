variable "rg_name" {
  type = string
}
variable "rg_location" {
  type = string
}
variable "nsg_linux_name" {
  type = string
}
variable "nsg_rules_linux" {
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
variable "vnet_name" {
  type = string
}
variable "vnet_address_space" {
  type = list(string)
}
variable "subnet_names" {
  type    = list(string)
  default = ["snet-01", "snet-02"]
}
variable "vm_qtd" {
  type = number
}

variable "pip_name_linux" {
  type = string
}
variable "nic_linux_name" {
  type = string
}
variable "vm_linux_name" {
  type = string
}
variable "vm_linux_size" {
  type = string
}
variable "tags_linux" {
  type = map(string)
}