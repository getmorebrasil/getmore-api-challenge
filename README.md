# Market

Take a look at the tests!

## Dev run

`Tested with elixir version 1.10.4, OTP 23 and podman version 2.0.5`

```
# Install deps
mix deps.get

# Setup Postgres
podman run -d --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres
podman run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
mix ecto.setup

# Start server
iex -S mix

# Send some commands like:
RPX.AMQP.Client.call("shops", "list_products", []) |> Task.await
```

Note: RPX lib with serious problems, please fix that

