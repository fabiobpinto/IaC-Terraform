output "vm_linux_pip" {
  value = [for pip in azurerm_public_ip.pip_linux : pip.ip_address]
}