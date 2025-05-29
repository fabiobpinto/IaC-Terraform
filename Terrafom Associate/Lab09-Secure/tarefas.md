Objetivo:

Integrar Azure Key Vault para consumir senhas e credenciais no código de Terraform.

[Hands-On] Terraform Secure Variables and Secrets

1 - Criar Azure Key Vault.

        Logar no Azure via Az CLI
            az login --service-principal -t <Tenant-ID> -u <Client-ID> -p <Client-secret>
            az account list
            az account set -s <subscription-id>

        Criar o rg-acme-kv para a criação do Key Vault
            az group create --name rg-acme-kv --location eastus

        Criar o Key Vault
            az keyvault create --name "kv-acme-01" --resource-group "rg-acme-kv" --location "East US"

2 - Criar senha no Azure Key Vault.
        Senha
            az keyvault secret set --vault-name "kv-acme-01" --name "acme-secret" --value "P@ssw0rd1234"

3 - Criar módulo de vm linux com bloco de data para consumir as informações do Azure Key Vault.
4 - Implantar um recurso do Azure usando o Terraform e utilizar a senha armazenada no Azure Key Vault.
5 - Acessar a vm linux via ssh e validar a senha armazenada no Azure Key Vault.


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret