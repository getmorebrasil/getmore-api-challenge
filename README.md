# Challenge Getmore-Api Team

## Solution (Implementation)

> **[x]** Popule o banco com o products.json que está no projeto.

`npx knex seed:run` did the hard work.

> **[x]** Ter uma api que gerencía um catálogo de produtos, ela deve listar os produtos paginados através de um endpoint.

Can be used through [/products?n=10&p=2](http://localhost:4000/products/?n=10&p=2)

Please, try to fool me [/products/?n=-1&p=-1](http://localhost:4000/products/?n=-1&p=-1). You won't be able.

> **[x]** Foi definido com o time de desenvolvimento que o serviço será uma aplicação distribuida com a arquitetura de orquestração. Nesse caso também deverá ser construido um orquestrador, que faz o controle de acesso ao serviço de produtos, para o usuário final.
> A comunicação entre o orquestrador e o serviço deve ser via protocolo amqp utilizando o serviço de mensageria rabbitMq.

### How to test

Install dependencies.

`npm install`

Create a postgresql database named `getmore`. Current user need to have access to postgresql.

`createdb getmore`

Migrate Products table structure.

`npx knex migrate:latest`

Now seed it with the `products.json`.

`npx knex seed:run`

As instructed in the challenge, get `rabbitmq` running.

`docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management`

rabbitmq service can be controlled through [http://localhost:15672](http://localhost:15672). User guest, password guest.

Start this challenge service.

`npm start`

Test some GET requests.

[http://localhost:4000/products?n=10&p=2](http://localhost:4000/products?n=10&p=2)

[http://localhost:4000/products](http://localhost:4000/products)

### _In progress_

### Used commands while implementing

```
❯ npm install express
❯ npm install cors
❯ npm install nodemon -D
❯ npm install knex
❯ npm install pg

❯ npx knex init
❯ createdb getmore
❯ npx knex migrate:make create_products
❯ npx knex migrate:latest
❯ psql -d getmore
getmore=# \dt+
 public | knex_migrations      | table | uzu   | 8192 bytes |
 public | knex_migrations_lock | table | uzu   | 8192 bytes |
 public | products             | table | uzu   | 56 kB      |
❯ npx knex seed:make seed_products
❯ npx knex seed:run
❯ psql -d getmore
getmore=# select count(*) from products;
   200

❯ git submodule add -- https://github.com/getmorebrasil/rpc-client-js

❯ npm install amqplib
❯ npm install node-uuid

❯ npm start
```

---

Considere o seguinte cenário.

Sua empresa acabou de fechar uma novo produto e o PO detalhou as seguintes necessidades:

Ter uma api que gerencía um catálogo de produtos, ela deve listar os produtos paginados através de um endpoint.

Popule o banco com o products.json que está no projeto.

Foi definido com o time de desenvolvimento que o serviço será uma aplicação distribuida com a arquitetura de orquestração.
Nesse caso também deverá ser construido um orquestrador, que faz o controle de acesso ao serviço de produtos, para o usuário final.

Com as necessidades requeridas pelo PO e a definição de arquitetura com time de desenvolvimento foram decididos os seguintes requisitos:

> A comunicação entre o orquestrador e o serviço deve ser via protocolo amqp
> utilizando o serviço de mensageria rabbitMq.
> Para subir o serviço de mensageria

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
