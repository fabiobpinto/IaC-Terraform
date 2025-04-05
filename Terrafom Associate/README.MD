# Introdução

Este repositório foi criado para auxiliar nos estudos e práticas relacionadas ao exame Terraform Associate. Aqui você encontrará laboratórios, exemplos e materiais que ajudarão a consolidar os conceitos fundamentais do Terraform e a se preparar para a certificação. Sinta-se à vontade para explorar, contribuir e compartilhar conhecimento!

## Instalando Terraform no Linux Ubuntu

[Documentação oficial de instalação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


```bash
# Atualize os pacotes e instale dependências necessárias
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Adicione a chave HashiCorp GPG
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Adicione o repositório oficial HashiCorp Linux
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Instalando o Terraform
sudo apt install terraform

# Verifique se o Terraform foi instalado com sucesso
terraform -help

# Instalando o Autocomplete
terraform -install-autocomplete
```


### Principais Itens no Terraform

1. **Providers**: Interagem com as APIs dos serviços que você deseja gerenciar (AWS, Azure, Google Cloud, etc.).

2. **Resources**: Componentes da infraestrutura que você deseja criar ou gerenciar (instâncias de máquinas virtuais, bancos de dados, redes, etc.).

3. **Variables**: Parametrizam o código, facilitando a reutilização e a configuração dinâmica dos recursos.

4. **Outputs**: Valores retornados após a execução do Terraform, úteis para expor informações importantes sobre os recursos criados.

5. **Modules**: Conjuntos de recursos agrupados em um único bloco reutilizável, permitindo a organização e reutilização de código.

6. **State**: Armazena o estado atual da infraestrutura gerenciada pelo Terraform, garantindo a consistência entre o código e a infraestrutura real.

7. **Data Sources**: Buscam informações de recursos existentes fora do Terraform, que podem ser usados para configurar outros recursos.

8. **Provisioners**: Executam scripts ou comandos em recursos após sua criação ou destruição, permitindo configurações adicionais.

### Conceitos Adicionais no Terraform

9. **Backend**: Define onde e como o estado do Terraform é armazenado (local ou remoto, como em um bucket S3 na AWS).

10. **Local Values**: Variáveis locais dentro de um módulo, facilitando a reutilização de valores calculados ou constantes.

11. **Lifecycle**: Configurações que controlam o comportamento de criação, atualização e destruição de recursos (create_before_destroy, prevent_destroy).

12. **Meta-Arguments**: Argumentos especiais usados em recursos (count, for_each, depends_on), que ajudam a controlar a criação e dependências dos recursos.

13. **Dynamic Blocks**: Criação de blocos de configuração dinâmicos dentro de recursos, úteis quando a quantidade de sub-recursos varia.

14. **Remote State**: Compartilha o estado do Terraform entre diferentes configurações ou equipes, facilitando a colaboração e a consistência.

### Comandos Úteis no Terraform

1. **terraform init**: Inicializa o diretório de trabalho contendo os arquivos de configuração do Terraform.

2. **terraform validate**: Verifica a sintaxe e a consistência dos arquivos de configuração do Terraform.

3. **terraform plan**: Gera um plano de execução mostrando as mudanças que o Terraform fará na infraestrutura.

4. **terraform apply**: Aplica as mudanças planejadas na infraestrutura.

5. **terraform destroy**: Remove todos os recursos gerenciados pelo Terraform.

6. **terraform fmt**: Formata automaticamente os arquivos de configuração do Terraform.

7. **terraform show**: Exibe informações detalhadas sobre o estado atual da infraestrutura gerenciada pelo Terraform.

8. **terraform output**: Exibe os valores de saída definidos na configuração do Terraform.

9. **terraform refresh**: Atualiza o estado do Terraform com a infraestrutura real.

10. **terraform graph**: Gera um gráfico visual da configuração do Terraform.

11. **terraform state**: Gerencia o estado do Terraform, permitindo visualizar, mover e remover recursos do estado.

12. **terraform taint**: Marca um recurso específico para ser destruído e recriado na próxima execução do terraform apply.

13. **terraform untaint**: Remove a marcação de um recurso que foi marcado como "tainted".

14. **terraform import**: Importa recursos existentes na infraestrutura para o estado do Terraform.

15. **terraform workspace**: Gerencia múltiplos workspaces, permitindo isolar diferentes ambientes dentro do mesmo diretório de configuração.

### Produtos Relacionados ao Terraform

- *HCP Terraform*: Serviço de automação de infraestrutura como código, que oferece uma maneira gerenciada de usar o Terraform com recursos adicionais, como gerenciamento de estado remoto e colaboração[1](https://www.hashicorp.com/products/terraform)[2](https://www.terraform.io/?lang=en).

Esses itens e produtos ajudam a tornar o Terraform uma ferramenta poderosa e flexível para gerenciar infraestrutura como código. Se precisar de mais alguma coisa, estou à disposição!

[1](https://www.hashicorp.com/products/terraform): [HashiCorp Terraform](https://www.hashicorp.com/products/terraform)
[2](https://www.terraform.io/?lang=en): [Terraform by HashiCorp](https://www.terraform.io/?lang=en)

### Terraform Cloud

Terraform Cloud é uma plataforma SaaS (Software as a Service) que oferece uma maneira gerenciada de usar o Terraform. Algumas das principais funcionalidades incluem:

- *Gerenciamento de Estado Remoto*: Armazena o estado do Terraform de forma segura e centralizada.
- *Colaboração*: Permite que equipes colaborem em configurações de infraestrutura, com controle de acesso e histórico de mudanças.
- *Execuções Automatizadas*: Suporta execuções automáticas de planos e aplicações de infraestrutura.
- *Integração com VCS*: Integra-se com sistemas de controle de versão (como GitHub, GitLab, Bitbucket) para automação de fluxos de trabalho.
- *Notificações e Webhooks*: Envia notificações e integra-se com outras ferramentas através de webhooks.
- *Políticas como Código*: Utiliza o Sentinel para definir políticas de segurança e conformidade que são aplicadas durante as execuções.

### Terraform Enterprise

Terraform Enterprise é a versão on-premises do Terraform Cloud, oferecendo funcionalidades adicionais e maior controle para grandes organizações. Algumas das principais funcionalidades incluem:

- *Segurança Avançada*: Oferece controle de acesso granular, autenticação e autorização avançadas.
- *Escalabilidade*: Suporta grandes volumes de execuções e múltiplos workspaces.
- *Integração com Ferramentas Corporativas*: Integra-se com ferramentas de CI/CD, sistemas de gerenciamento de identidade e outras soluções corporativas.
- *Suporte e SLA*: Inclui suporte técnico da HashiCorp e acordos de nível de serviço (SLA) para garantir alta disponibilidade e desempenho.
- *Auditoria e Conformidade*: Fornece logs detalhados e trilhas de auditoria para conformidade regulatória.

Essas plataformas são projetadas para facilitar a adoção do Terraform em ambientes corporativos, oferecendo recursos adicionais para segurança, colaboração e automação.
