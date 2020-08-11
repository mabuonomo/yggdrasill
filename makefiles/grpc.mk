basePath = ./grpc

__proto_build_client:
	@mkdir ${basePath}/build || true
	@rm -R ${basePath}/build/nestjs/* || true
	@mkdir ${basePath}/build/nestjs || true
	@${docker} ${container} sh ${basePath}/compile.client.proto.sh

#build for web/nestjs
grpc_build: __proto_build_client