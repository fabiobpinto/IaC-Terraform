## Objetivos do Lab:

### Importar recursos existentes do Azure para serem gerenciados pelo Terraform.
#### Terraform Import

00 - Criar o Resource Group no Portal do Azure.
01 - Criar um ip public no Portal do Azure.
02 - Coletar as informações para importar os recursos para o Terraform.
03 - Configurar o import block para importar os recursos.
04 - Configurar o resource block do recurso que será importado
05 - Aplicar os comandos para planejar e importar os recursos do Azure para o state do Terraform terraform.tfstate.
06 - Utilizar o comando -generate-config-out para geração automatica dos blocos de recursos.
07 - Utilizar os comandos para planejar e importar os recusos do Azure para o state do terraform.
08 - Aplicar alterações nos recursos importados via terraform.

terraform plan -generate-config-out=generated-resources-pip.tf