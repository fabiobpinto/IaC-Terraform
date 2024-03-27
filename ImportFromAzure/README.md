# Import From Azure

Importação de uma Infra já criada no Azure.

No exemplo tenho uma VNET em um RG que serão importados.

# Procedimentos
Listar os states, vai dar erro pois não temos nada ainda
`terraform state list`

Precisamos do ID do RG para importalo.
`az group list`

Comando para importar o RG, será importado para o terraform.tfstate
`terraform import azurerm_resource_group.rg /subscriptions/aaaaaaaaa-xxxx-xxxx-xxxx-bbbbbbbb/resourceGroups/RG-Terraform-Import`

Listar os states, não dará erro agora pois importamos 
`terraform state list`

Comando para importar a VNET
`terraform import azurerm_virtual_network.vnet /subscriptions/aaaaaaaaa-xxxx-xxxx-xxxx-bbbbbbbb/resourceGroups/RG-Terraform-Import/providers/Microsoft.Network/virtualNetworks/vnet-import`

Comando para importar o NSG
`terraform import azurerm_network_security_group.nsg /subscriptions/aaaaaaaaa-xxxx-xxxx-xxxx-bbbbbbbb/resourceGroups/RG-Terraform-Import/providers/Microsoft.Network/networkSecurityGroups/nsg-import`

# Link para ferramenta do Terraform Graph
https://terraform.io/docks/cli/commands/graph.html