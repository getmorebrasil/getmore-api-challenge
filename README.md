# Sumário
- [Estrutura do projeto](#estrutura-do-projeto)
- [Instalação](#instalação)
- [Database](#database)
- [AMQP](#amqp)
- [Executar](#executar)
- [Testes](#testes)
- [Desafio](#challenge-getmore-api-team)

## Estrutura do projeto
    .
    ├── ...
    ├── __test__                      # Pasta com os testes
    │   ├── database.test.js          # Testes do database (standalone)
    │   └── server.test.js            # Testes do projeto executando como um todo
    │                  
    ├── database                      # Pasta com a implementação para o Postgres
    │   ├── index.js                  # Core da implementação da database
    │   └── queries.js                # Queries usadas no ./index.js
    │                   
    ├── rpc-client-js                 # Cliente rpc com protocolo amqp implementado pela Getmore
    │   └── ...                
    │                  
    ├── server                        # Pasta com o principal do desafio
    │   ├── index-consumer.js         # Conexão do consumer do rpc-client
    │   ├── index-producer.js         # Conexão do producer do rpc-client
    │   ├── index.js                  # Express e rotas, __executa o projeto__
    │   ├── interface.js              # Interface utilizada pelo consumer
    │   ├── populateDatabase.js       # Implementação para popular o banco de dados com o ../products.json
    │   └── testProducer.js           # Simples teste do producer
    │                  
    ├── products.json                 # Array com objetos de produtos, dado no desafio
    └── ...



## Instalação
- Instalar as dependências:
```
yarn install // qualquer chamada ao yarn neste e nos proximos passos, pode ser substituido por npm
```

- Criar uma database no postgress

- Criar um .env com as seguintes variaveis (variaveis entre chaves devem ser alteradas de acordo com o seu postgres e suas configurações):
```
PGHOST=localhost
PGPORT=5432
PGUSER={_user}
PGPASSWORD={_senha}
PGDATABASE={_nome_da_database_criada}
```

## Database
- Para popular o banco de dados:
```
node server/populateDatabase.js
```
- O banco de dados será preenchido com os objetos presentes no arquivo products.json, exemplo da estrutura de um produto:
```
{
  "productId": 1001,
  "productCategory": "Category 2",
  "productName": "Product 1",
  "productImage": "https://picsum.photos/400?image=333",
  "productStock": true,
  "productPrice": 1871.425
}
```

## AMQP
- Para utilizar o protocolo, rodar a imagem docker:
```
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```
- Para testar e visualizar de maneira mais aparente a orquestração, descomentar o `await timeout` no arquivo `server/interface.js` e rodar normalmente `yarn consumer` e `yarn producer`

## Executar
> Antes de executar, rode o comando para [popular o banco de dados](#database) com os produtos

- Executar (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação)):
```
yarn start
```
> Ao executar, já começa com um consumer, para adicionar mais consumers (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação)):
```
yarn consumer
```
- Para executar em modo de desenvolvimento (requisitos: iniciar [imagem docker](#amqp) e feito os [passos de instalação](#instalação)):
```
yarn dev
```
- Rota para testar: `http://localhost:4000/products/{page}&{itemsPerPage}`, onde as variaveis entre chaves devem ser trocadas de acordo com a paginação desejada, por exemplo: deseja-se obter a página 3, com 10 produtos por página, então o endereço seria: <a href="localhost:4000/products/3&10">http://localhost:4000/products/3&10</a>, por default: `page = 0 e itemsPerPage = 5 `. Pode-se também ser informado apenas a página desejada, desta maneira os itens por páginas serão 5 por default. O máximo de produtos por página está definido na variavel de ambiente MAX_ITEMS_PER_PAGE, que por default é 10.

## Testes
- Rodar os testes automatizados com jest (precisa ter [iniciado o server](#executar)):
```
yarn test
```

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


