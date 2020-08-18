docker exec node sh -c "yarn typeorm migration:run && yarn ts-node src/database/populate.ts && yarn dev:server"
