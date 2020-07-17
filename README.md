# Sumário
- [Desafio](#challenge-getmore-api-team)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Instalação](#instalação)
- [Database](#database)
- [Executar](#executar)

# Challenge Getmore-Api Team

Considere o seguinte cenário.

Sua empresa acabou de fechar uma novo produto e o PO detalhou as seguintes necessidades:

Ter uma api que gerencía um catálogo de produtos, ela deve listar os produtos paginados através de um endpoint.

Popule o banco com o products.json que está no projeto.

Foi definido com o time de desenvolvimento que o serviço será uma aplicação distribuida com a arquitetura de orquestração.
Nesse caso também deverá ser construido um orquestrador, que faz o controle de acesso ao serviço de produtos, para o usuário final.

Com as necessidades requeridas pelo PO e a definição de arquitetura com time de desenvolvimento foram decididos os seguintes requisitos:

> A comunicação entre o orquestrador e o serviço deve ser via protocolo amqp
utilizando o serviço de mensageria rabbitMq.
Para subir o serviço de mensageria
```
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```
![N|Solid](https://pubs.vmware.com/vfabricRabbitMQ31/topic/com.vmware.vfabric.rabbitmq.3.1/rabbit-web-docs/img/tutorials/intro/hello-world-example-routing.png)

**Tecnologias:**

- Sua api pode ser construida em qualquer linguagem.
- Seu banco de dados pode ser qualquer um.

**Dicas:**

Você terá pontos extras:

- Desenvolver em elixir e/ou javscript/typescript.
- Utilizar Postgres.
- Utilizar paradigma funcional.

Lib de comunicação para o protocolo:
- lib de comunicação em javascript
https://github.com/getmorebrasil/rpc-client-js

- lib de comunicação em elixir
https://github.com/getmorebrasil/rpx 

**Aqui vão as etapas:**
 - Faça um fork desse repositório;
 - Crie uma Pull Request com sua fork

## Estrutura do projeto

    .
    ├── src
    |   ├── ...
    |   ├── database                       # Pasta com a implementação para o Postgres
    |   │   ├── migrations                 # Schema de criação, alteração e deleção de tabelas
    |   |   |   └── 0_create_products.ts   # Criação da tabela products
    |   |   |
    |   |   ├── seeds                      # Populam o database com dados pré-definidas
    |   |   |   └── create_products.ts     # Populam a tabela products com os dados do arquivo products.json
    |   |   |
    |   │   └── connection.ts              # Configurações do database
    |   │  
    |   ├── repositories                   # Pasta com consultas no database
    |   │   └── seach-products-database.ts # Pesquisa os produtos no database
    |   |             
    |   ├── rpc-client-js                  # Lib de comunicação em javascript
    |   │   └── ...                
    |   │                  
    |   ├── server                         # Pasta com a solução do desafio
    |   │   ├── index-consumer.ts          # Conexão do consumer do rpc-client
    |   │   ├── index-producer.ts          # Conexão do producer do rpc-client
    |   │   ├── index.ts                   # Configuração do express e rotas
    |   │   └── interface.ts               # Interface utilizada pelo consumer
    |   │                  
    |   └── routes.ts                      # Possui as rotas do desafio
    |
    ├── knexfile.ts                        # Configurações do knex e criação do database
    |
   ...

## Instalação

- Instalar as dependências do projeto:

```
npm install
```

## Database

- Para criar o banco de dados:

```
npm run knex:migrate
```

- Para popular o banco de dados com os dados fornecidos:

```
npm run knex:seed
```

> O desafio foi desenvolvido utilizando o banco de dados Sqlite, porém a implementação foi feita utilizando o knex. Dessa forma, para utilizar outros bancos que se achar conveniente basta trocar as configurações do arquivo ./src/knexfile.ts e ./src/database/connection.ts

## Executar

- Para subir o serviço de mensageria:

```
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```

- Executar:

```
npm run start
```

- Executar:

```
npm run consumer
```
