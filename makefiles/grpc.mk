docker = docker-compose run --rm -u 1000

__init:
	cd ./grpc && ${docker} generic 		npm install

__proto_build_client: __init
	cd ./grpc && rm -R ./build/nestjs/* || true
	cd ./grpc && mkdir ./build/nestjs || true
	cd ./grpc && ${docker} generic 		sh compile.client.proto.sh

#build for web/nestjs
grpc_build: __proto_build_client
	cd ./grpc && ${docker} generic		npm run build