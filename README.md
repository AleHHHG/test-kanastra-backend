
# Teste Backend Kanastra

## Ferramentas

- RabbitMQ
- Postgres
- Cron
- RSpec


## Rodando localmente

Build o container

```bash
  docker compose build
```

Execute as migrações

```bash
  docker compose run web rake db:create
  docker compose run web rake db:migrate
```

Execute o container

```bash
  docker compose up
```

Execute os teste unitários

```bash
  docker compose run web bash -c "RAILS_ENV=test bundle exec rspec"
```



## Importante

Com a aplicação rodando e necessario acessar o rabbitmq e criar um virtual host com o nome kanastra.

`http://localhost:15672/#/vhosts`



## Documentação da API

#### Retorna todas as cobranças

```http
  GET /billings
```

| Parâmetro   | Tipo       | Descrição                           |
| :---------- | :--------- | :---------------------------------- |
| `page` | `integer` | Paginação |

#### Importa as cobranças

```http
  POST /billings/import
```

| Parâmetro   | Tipo       | Descrição                                   |
| :---------- | :--------- | :------------------------------------------ |
| `file`      | `file` | **Obrigatório**. Aceita apenas arquivos .csv |
