
# Configuração de Ambiente com Docker Compose

## Pré-requisitos:

- Docker
- Docker Compose

## Uso:

Primeiro clone o repositório:

    git clone https://github.com/CaianSantana/RocketSeat-DevOps.git

Navegue até o diretório Docker:

    cd RocketSeat-DevOps/Docker/

Suba os containeres com o `Docker Compose`:

    docker compose up --build -d

- `docker compose up`: Sobe as instâncias dos containeres;
- `--build`: Constrói as imagens antes de executa-las;
- `-d`: Deixa os logs em segundo plano.

Para visualizar os logs:

    docker compose logs -f