docker = docker-compose run --rm -u 1000
basePath = ./grpc

__init:
	cd ./grpc && ${docker} generic 		npm install

__proto_build_client: __init
	mkdir ${basePath}/build || true
	rm -R ${basePath}/build/nestjs/* || true
	mkdir ${basePath}/build/nestjs || true
	cd ./grpc && ${docker} generic 		sh compile.client.proto.sh

#build for web/nestjs
grpc_build: __proto_build_client