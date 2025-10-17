# Projeto de Infraestrutura AWS com Terraform

Este repositório contém o código de "Infraestrutura como Código" (IaC) para provisionar os recursos de nuvem na AWS. O projeto é totalmente modularizado e organizado para gerenciar múltiplos ambientes de forma segura e isolada.

## Estrutura do Projeto

A arquitetura do projeto é dividida em duas áreas principais: `modules` e `environments`. Essa separação garante a reutilização de código (princípio DRY) e o isolamento total entre os ambientes.

```
.
├── environments
│   ├── dev
│   ├── prod
│   └── test
└── modules
    ├── ec2
    └── vpc
```

  * **`/modules`**: Contém a lógica reutilizável que define *como* construir um componente da nossa infraestrutura.

      * `vpc`: Define como criar uma VPC, com sub-redes, tabelas de rotas e um Security Group.
      * `ec2`: Define como criar uma ou mais instâncias EC2.

  * **`/environments`**: Cada subdiretório é um ambiente completamente isolado (`dev`, `prod`, `test`). É a partir daqui que executamos os comandos do Terraform. Cada ambiente chama os módulos necessários e os configura com variáveis específicas.

-----

## Ambientes

Cada ambiente tem uma configuração específica para atender às suas necessidades de custo e performance. O ambiente `dev` não possui ELB.

-----

## Módulos Utilizados

  * **`vpc`**: Módulo customizado, criado internamente. Responsável por provisionar a rede base, incluindo:
      * 1 VPC
      * 1 Sub-rede pública
      * 1 Security Group
  * **`ec2`**: Módulo customizado, criado internamente. Responsável por provisionar as instâncias EC2.
  * **`elb`**: Módulo da comunidade Terraform. Utilizado para criar um Classic Load Balancer.
      * **Fonte**: [`terraform-aws-modules/elb/aws`](https://www.google.com/search?q=%5Bhttps://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest%5D\(https://registry.terraform.io/modules/terraform-aws-modules/elb/aws/latest\))

-----

## Como Usar

### Pré-requisitos

1.  **Terraform CLI** instalado.
2.  **AWS CLI** instalado e configurado.
3.  Credenciais da AWS válidas (recomenda-se fazer login via `aws sso login`).

### Primeira Implantação (Bootstrap do Backend Remoto)

Para que o Terraform possa gerenciar o estado da infraestrutura de forma segura e remota, ele precisa de um bucket S3 que deve existir *antes* da primeira aplicação. O procedimento abaixo quebra esse paradoxo inicializando o estado localmente para criar o bucket e, em seguida, migrando o estado para ele.

**Siga estes passos para CADA ambiente (`dev`, `test`, `prod`) na primeira vez:**

1.  **Navegue até o diretório do ambiente desejado:**

    ```bash
    cd environments/dev
    ```

2.  **Comente o Bloco de Backend:**
    Abra o arquivo `backend.tf` e comente todo o bloco `terraform { backend "s3" { ... } }`. Isso forçará o Terraform a usar o backend local temporariamente.

3.  **Inicialize e Aplique Localmente:**
    Estes comandos criarão a infraestrutura (incluindo o bucket S3 para o estado) e salvarão o arquivo `terraform.tfstate` na sua máquina local.
    Lembre-se de criar um arquivo `dev.tfvars` com as especificações do ambiente!

    ```bash
    terraform init -backend-config="profile=<suaconta>"
    terraform plan -var-file="dev.tfvars"
    terraform apply -var-file="dev.tfvars" -auto-approve
    ```

4.  **Descomente o Bloco de Backend:**
    Abra o arquivo `backend.tf` novamente e remova os comentários do bloco.

5.  **Re-inicialize para Migrar o Estado:**
    Execute `terraform init -reconfigure -backend-config="profile=<suaconta>"` novamente. O Terraform detectará a nova configuração de backend e perguntará se você deseja copiar o estado local existente para o novo backend S3.

    ```bash
    terraform init -reconfigure -backend-config="profile=<suaconta>"
    ```

    Quando perguntado `Do you want to copy existing state to the new backend?`, digite `yes` e pressione Enter.

Pronto\! A partir de agora, o estado deste ambiente será gerenciado de forma remota e segura no S3.

### Operações Padrão (Após a Primeira Implantação)

Para fazer qualquer alteração na infraestrutura de um ambiente, o fluxo é muito mais simples:

1.  **Navegue até o diretório do ambiente:**

    ```bash
    cd environments/dev
    ```

2.  **Planeje e Aplique as Mudanças:**

    ```bash

    terraform fmt
    terraform validate
    terraform plan -var-file="dev.tfvars"
    terraform apply -auto-approve -var-file="dev.tfvars"
    ```

### Destruindo o Ambiente

Para remover toda a infraestrutura de um ambiente, use o comando `destroy`.

```bash
cd environments/dev
terraform destroy -var-file="dev.tfvars"
```

> **Atenção**: Para destruir o próprio bucket S3 que guarda o estado, talvez seja necessário comentar o bloco `backend.tf` novamente, re-inicializar com `init` e então rodar o `destroy`.