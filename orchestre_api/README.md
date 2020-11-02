# OrchestreApi

Para iniciar a API:

  * Instalar as dependências do projeto `mix deps.get`
  * Iniciar or server da aplicação `mix phx.server`

A OrchestreApi é uma API Rest que recebe chamadas HTTP e realiza a comunicação através chamadas RCP com o serviço Products.
Para realizar uma chamada para a API utilize a URL: 
  * http://localhost:4000/api/products?page=1&page_size=30
  * Os parâmetros page e page_size dizem respeito a paginação, onde page é o número da página e page_size a quantidade de registros que virão na requsição.