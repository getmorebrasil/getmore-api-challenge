docker ps -q --filter "name=getmore_postgres" | grep -q . && docker stop getmore_postgres && docker rm -fv getmore_postgres
docker ps -q --filter "name=getmore_rabbit" | grep -q . && docker stop getmore_rabbit && docker rm -fv getmore_rabbit
docker ps -q --filter "name=getmore_node" | grep -q . && docker stop getmore_node && docker rm -fv getmore_node

docker build -t pedronobrega/dockernode -f node.Dockerfile .
docker build -t pedronobrega/dockerpostgres -f postgres.Dockerfile .

docker-compose up

sleep(3)
