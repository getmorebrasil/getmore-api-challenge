# Execução

Inicializar os serviços necessários:
```
docker-compose up -d --build
```

Executar as migrações necessárias:
```

docker-compose exec products bin/products eval "Products.Release.migrate"
```

Executar a seed de produtos:
```
cd products && \
RABBITMQ_URI=amqp://rabbitmq:rabbitmq@localhost \
DATABASE_URL=ecto://postgres:postgres@localhost/products \
mix run priv/repo/seeds.exs
```
