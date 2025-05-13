# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/c30c5829-2a81-4982-8141-09566ee674d6/resourceGroups/rg-acme-import-portal/providers/Microsoft.Network/publicIPAddresses/pip-acme-import"
resource "azurerm_public_ip" "pip-import" {
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  ddos_protection_plan_id = null
  domain_name_label       = null
  domain_name_label_scope = null
  edge_zone               = null
  idle_timeout_in_minutes = 4
  ip_tags                 = {}
  ip_version              = "IPv4"
  location                = "eastus"
  name                    = "pip-acme-import"
  public_ip_prefix_id     = null
  resource_group_name     = "rg-acme-import-portal"
  reverse_fqdn            = null
  sku                     = "Standard"
  sku_tier                = "Regional"
  tags                    = {
    import   = "OK"
    ambiente = "dev"
  }
  zones                   = ["1", "2", "3"]
}
