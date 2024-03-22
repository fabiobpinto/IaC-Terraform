# Terraform em Pastas

Uso em ambientes pequenos, ruim por que tem que duplicar o ambiente

Ao criar um ambiente ele exclui o outro.


`$ terraform plan --var-file="dev/main.tfvars"`
`$ terraform plan --var-file="prod/main.tfvars"`