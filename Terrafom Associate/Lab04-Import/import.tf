# Importing a resource group into Terraform state
# 03 - Configurar o import block para importar os recursos.
import {
  id = "/subscriptions/c30c5829-2a81-4982-8141-09566ee674d6/resourceGroups/rg-acme-import-portal"
  to = module.rg_import_module.azurerm_resource_group.rg-import
}

# Importing a Public IP into Terraform state (with code)
import {
  id = "/subscriptions/c30c5829-2a81-4982-8141-09566ee674d6/resourceGroups/rg-acme-import-portal/providers/Microsoft.Network/publicIPAddresses/pip-acme-import"
  to = azurerm_public_ip.pip-import
}