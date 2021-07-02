# Challenge Getmore-Api Team

## Como utilizar 
Inicie o serviço de mensageria:
```bash
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```

Crie a migração de dados:
```bash
mix ecto.migrate
```
Popule o banco (PostgreSQL):
```bash
mix run priv/repo/seeds.exs
```

Inicie o servidor:
```bash
mix phx.server
```
Acesse a rota com os parâmetros `page` e `page_size`.   
Exemplo:            
`http://localhost:4000/api/products/?page=1&page_size=3` 


## Desafio 

Considere o seguinte cenário.

Sua empresa acabou de fechar uma novo produto e o PO detalhou as seguintes necessidades:

Ter uma api que gerencía um catálogo de produtos, ela deve listar os produtos paginados através de um endpoint.

Popule o banco com o products.json que está no projeto.

Foi definido com o time de desenvolvimento que o serviço será uma aplicação distribuida com a arquitetura de orquestração.
Nesse caso também deverá ser construido um orquestrador, que faz o controle de acesso ao serviço de produtos, para o usuário final.

Com as necessidades requeridas pelo PO e a definição de arquitetura com time de desenvolvimento foram decididos os seguintes requisitos:

> A comunicação entre o orquestrador e o serviço deve ser via protocolo amqp
utilizando o serviço de mensageria rabbitMq.

![N|Solid](https://www.rabbitmq.com/img/tutorials/intro/hello-world-example-routing.png)


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
https://hexdocs.pm/amqp/readme.html

**Aqui vão as etapas:**
 - Faça um fork desse repositório;
 - Crie uma Pull Request com sua fork