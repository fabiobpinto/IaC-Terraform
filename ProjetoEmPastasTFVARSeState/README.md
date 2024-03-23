# Terraform em Pastas

Uso em ambientes pequenos, ruim por que tem que duplicar o ambiente

Ao criar um ambiente ele exclui o outro.


`$ terraform plan -var-file="dev/main.tfvars" -state="dev/main.tfstate" -out="dev/main.tfplan"`
`$ terraform apply -var-file="dev/main.tfvars" -state="dev/main.tfstate"`
`$ terraform destroy -var-file="dev/main.tfvars" -state="dev/main.tfstate"`