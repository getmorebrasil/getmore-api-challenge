## Instalação
- Instalar as dependências:
```javascript
yarn install // qualquer chamada ao yarn neste e nos proximos passos, pode ser substituido por npm
```

- Criar uma database no postgress
- Criar a tabela 'Products'

- Criar um .env com as seguintes variaveis (variaveis entre chaves devem ser alteradas de acordo com o seu postgres e suas configurações):
```javascript
PGHOST=localhost
PGPORT=5432
PGUSER={_user}
PGPASSWORD={_senha}
PGDATABASE={_nome_da_database_criada}
```

# Database
- Para testar apenas o db:
```javascript
node server/testDB.js
```

# AMQP
- Para utilizar o protocolo, rodar a imagem docker:
```
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```
- Para testar e visualizar de maneira mais aparente a orquestração, descomentar o `await timeout` no arquivo `server/interface.js` e rodar normalmente o `server/index-consumer.js` e o `./server/testProducer.js` ou `yarn consumer` e `yarn producer`

# Express
- Startar (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação)):
```javascript
yarn start
```
> Ao startar, já começa com um consumer, para adicionar mais consumers (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação):
```javascript
yarn consumer
```
para startar em modo de desenvolvimento (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação)):
```javascript
yarn dev
```
- Rota para testar: `http://localhost:4000/products/{itemsPerPage}&{page}`, onde as variaveis entre chaves devem ser trocadas de acordo com a paginação desejada, por exemplo: se eu quero pegar 10 produtos por página e página 3, então o endereço seria: <a href="localhost:4000/products/10&3">`http://localhost:4000/products/10&3`</a>, por default: `itemsPerPage = 5 e page = 0`

# Tests com Jest: fazer

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


