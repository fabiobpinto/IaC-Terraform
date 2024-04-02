# IaCTerraform

Repositorio de Estudo do Terraform.


# What is Terraform?
Terraform is an infrastructure as code tool that lets you build, change, and version infrastructure safely and efficiently. This includes low-level components like compute instances, storage, and networking; and high-level components like DNS entries and SaaS features.

# Folders
| Folder  | O que é   |
| ------------ | ------------ |
|AzureCLI| Executar comandos do Az cli pelo VSCode  |
|BlobStorage| Criar um Blobstorage e Container |
|Concatenar| Concatenação de Strings  |
|Conditional| Condicionais  |
|Date| Trabalhando com Datas  |
|LoopsDependsOn| Loops e DependsOn  |
|Provisioners| Alguns providers Random, azurerm, file  |
|StateStorage| Salvar o STATE no Storage  |
|Strings| Usando Stringsd  |
|ProjetoEmPastasAppService| Arquivos separados em pastas   |
|ProjetoEmPastasComTFVARS| Arquivos tfvars separados em pastas  |
|ProjetoEmPastasComTFVARS| Arquivos tfvars e State separados em pastas  |
|Variables| Uso de Variaveis  |
|VSCode-ResourceGroup| Criar Resource Group pelo VSCode  |
|Modules| Usando estrutura em modulos  |
|Workspace| Usando estrutura Workspace  |
|Yeoman| Ferramenta de criação de Templates  |
|ImportFromAzure| Infra importado do Azure|
|SecurityKeyVault| Salvar senha no KeyVault|
|WebSite| Criação de WebSite Estático com Terraform|
|AppServicesSlots| Criação de AppServices com Slots com Terraform|


## Analises dos códigos
Como segurança dos nossos códigos podemos usar o Checkov para verificar as vulnerabilidades do mesmo.
Ele sugere correções a serem feitas nos códigos de IaC.
https://www.checkov.io/

Analise de Arquivo:
`chechov -f main.tf`

Analise de Diretorio
`chechov -d infra`
