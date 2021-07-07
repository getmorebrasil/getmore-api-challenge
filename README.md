Esse foi o maximo que consegui fazer pois não pussuo um bom conhecimento em Elixir nem postgres nem no protocolo pedido
então esse foi o que consegui fazer sem conheimento onde so importo o json pro postgress e imprimo atraves da api usando /api/product e api/product/id

sei que não é o esperado mas na vaga dizia vontade de aprender e eu fiz isso sem saber nada de elixir nem postgres nem do protocolo


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


