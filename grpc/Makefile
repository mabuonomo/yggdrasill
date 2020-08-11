docker = docker-compose run --rm -u 1000

init:
	${docker} generic 		npm install

proto_build_client: init
	rm -R ./build/nestjs/* || true
	mkdir ./build/nestjs || true
	${docker} generic 		sh compile.client.proto.sh

#build for web/nestjs
build-prod: proto_build_client
	${docker} generic		npm run build
