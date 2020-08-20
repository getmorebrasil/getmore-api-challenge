git submodule init
git submodule update

docker ps -q --filter "name=postgres" | grep -q . && docker stop postgres && docker rm -fv postgres
docker ps -q --filter "name=rabbit" | grep -q . && docker stop rabbit && docker rm -fv rabbit
docker ps -q --filter "name=node" | grep -q . && docker stop node && docker rm -fv node

docker build -t pedronobrega/dockerpostgres -f postgres.Dockerfile .
docker build -t pedronobrega/dockernode -f node.Dockerfile .

docker-compose up -d

docker cp setup.sql postgres:/docker-entrypoint-initdb.d/dump.sql
docker exec postgres psql typeorm typeorm -f docker-entrypoint-initdb.d/dump.sql
