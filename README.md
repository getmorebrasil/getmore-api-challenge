# Tecnologias utilizadas
O projeto foi escrito em Elixir, com seu framework web, o Phoenix; utilizando em conjunto o PostgreSQL como SGBD e o RabbitMQ como serviço de mensageria.

# Executando o projeto no seu computador

- Inicie o serviço de mensageria RabbitMQ com o comando:
```
docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```

- Nos dois diretórios (qatalog-data-service e qatalog-api-service), execute o comando ```mix deps.get``` para fazer download das dependências dos projetos e o comando ```mix deps.compile``` para compilá-las.
- No diretório qatalog-data-service, execute ```mix ecto.setup``` para configurar o banco de dados, executar as migrações e popular a tabela Products.
- Ainda no diretório qatalog-data-service, execute ```mix phx.server``` para iniciar a aplicação Phoenix que irá acessar o banco de dados PostgreSQL e consumir as mensagens do serviço de mensageria. Esta aplicação utiliza a porta 4001 por padrão
- No diretório qatalog-api-service, execute ```mix phx.server``` para iniciar a aplicação Phoenix que irá receber as requisições e publicar as messagens no serviç de mensageria. Esta aplicação utiliza a porta 4000 por padrão
- Para executar mais de um serviço para acesso ao banco de dados ao mesmo tempo sem que haja conflito entre portas no Phoenix, defina a variável de ambiente PORT=numero_da_porta antes de executar o comando ```mix phx.server``` no diretório qatalog-data-service. Exemplo: ```PORT=4002 mix phx.server```.

# Fazendo requisições à API
Para ter acesso aos produtos da API Qatalog, o usuário deve acessar o endereço http://localhost:4000/api/products/
Ao acessar a rota sem nenhum parâmetro, por padrão, será retornada a primeira página da listagem de produtos contendo 10 (dez) itens.
A API aceita os seguintes parâmetros de pesquisa:
- ```page=numero_da_pagina```: indica o número da página desejada (o padrão é a primeira página).
- ```items=numero_de_itens_na_pagina```: indica o número desejado de produtos por página (o padrão é que hajam 10 itens por página).
- ```orderByPrice=asc|desc```: indica que os produtos serão listados de forma crescente (opção 'asc') ou decrescente (opção 'desc') de acordo com o preço.
- ```inStock=true|false```: indica que apenas os produtos que estão em estoque (opção 'true') ou que não estão (opção 'false') serão listados.
- ```category=nome_da_categoria```: indica que apenas os produtos da categoria informada serão listados.
- Exemplo de URL: http://localhost:4000/api/products?orderByPrice=asc&inStock=true&page=3 (obtém a terceira página, listando apenas produtos em estoque e em ordem crescente.

Para obter os dados de um único produto, o usuário deve informar o id do mesmo após o caminho /api/products/.
- Exemplo de URL: http://localhost:4000/api/products/1001 (obtém os dados do produto com id 1001)



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


