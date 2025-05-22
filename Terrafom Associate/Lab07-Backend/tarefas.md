## Objetivos do Lab:

#### Terraform Remote Backend

01 - Criar um resource group
02 - Criar um Storage Account
03 - Criar um blob de Container
04 - Configurar o Backend remoto no Terraform
05 - Mover o backend local para o backend remoto no Azure.
```bash
terraform init -migrate-state
```
06 - Validar o novo ambiente
```bash
terraform state list
```
07 - Configurar o backend remoto no Terraform para Partial configuration
08 - Criar arquivos de partial configuration
backend_state.hcl
09 - Iniciar o backend com partial configuration
```bash
terraform init -backend-config="sbackend_state.hcl"
```

[Documentação de Configuração](https://developer.hashicorp.com/terraform/language/backend/azurerm)