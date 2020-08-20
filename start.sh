git submodule init
git submodule update
docker exec -d node sh -c "yarn typeorm migration:run && yarn ts-node src/database/populate.ts"
sleep 5
docker exec node sh -c "yarn dev:server"
