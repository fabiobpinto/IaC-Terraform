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

10 - Reconfigurar o seu Backend
```bash
terraform init -reconfigure -backend-config="sbackend_state.hcl"
```

Alternativa via CLI:
````bash
terraform init -reconfigure \
-backend-config "storage_account_name=$TF_BACKEND_STORAGE_ACCOUNT"  \
-backend-config "key=$TF_BACKEND_KEY"
.... demais codigos
````

[Documentação de Configuração](https://developer.hashicorp.com/terraform/language/backend/azurerm)