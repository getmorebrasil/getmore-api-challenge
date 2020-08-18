docker ps -q --filter "name=getmore_postgres" | grep -q . && docker stop getmore_postgres && docker rm -fv getmore_postgres
docker ps -q --filter "name=getmore_rabbit" | grep -q . && docker stop getmore_rabbit && docker rm -fv getmore_rabbit
docker ps -q --filter "name=getmore_node" | grep -q . && docker stop getmore_node && docker rm -fv getmore_node

docker build -t pedronobrega/dockerpostgres -f postgres.Dockerfile .
docker build -t pedronobrega/dockernode -f node.Dockerfile .

docker-compose up -d

docker cp setup.sql postgres:/docker-entrypoint-initdb.d/dump.sql
docker exec postgres psql typeorm typeorm -f docker-entrypoint-initdb.d/dump.sql
