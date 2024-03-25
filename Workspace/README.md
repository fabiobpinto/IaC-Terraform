# Terraform configurado com Workspaces

Modulos podem chamar outros modulos.
Podemos reutilizar os módulos para vários projetos.

Mais complexo.

### Alguns comandos do Terraform Workspace

Criar Workspace:
`$ terraform workspace new <workspace>`

Mostrar o Workspace onde estamos:
`$ terraform workspace show`

Listar todos os nossos Workspaces:
`$ terraform workspace list`

Selecionar o Workspace que iremos trabalhar:
`$ terraform workspace select <workspace>`

Deletar Workspace:
`$ terraform workspace delete <workspace>`