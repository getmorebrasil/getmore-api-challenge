# Products

Products é um serviço que recebe mensagens através de chamadas RPC.
O serviço possui conexão com o banco de dados para manipular a tabela de produtos e responder as requests.

## Para iniciar o serviço

  * Instalar as dependências do projeto `mix deps.get`
  * Iniciar o banco de dados `mix ecto.create` (a senha do postgres deve estar correta no arquivo 'config/config.exs')
  * Rodar o arquivo de migration para popular o banco de dados `mix run priv/repo/seeds.exs`
  * Iniciar o serviço `mix run --no-halt`
