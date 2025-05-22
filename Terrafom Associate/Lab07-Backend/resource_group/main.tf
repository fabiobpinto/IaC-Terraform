# 04 - Configurar o resource block do recurso que será importado
resource "azurerm_resource_group" "rg_import" {
  name     = "rg-acme-import-portal"
  location = "East US"
  tags = {
    import   = "OK"
    ambiente = "dev"
  }
}
