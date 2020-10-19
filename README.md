# GetmoreApiChallenge-RLSP

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browse to get all routes

## Paging (offset is 5)
mix phx.server

http://localhost:4000/api/products?page={page_number}

## To instal dependencies
mix deps.get

## To set up Postgres and RabbitMQ
docker-compose up

## Start server
iex -S mix

## Send some commands like:
RPX.AMQP.Client.call("products", "list_products", []) 
