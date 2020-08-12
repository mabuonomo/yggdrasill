__proto_build_client: npm_init
	@${docker} ${container} sh ./grpc/compile.client.proto.sh

#build for web/nestjs
grpc_build: __proto_build_client