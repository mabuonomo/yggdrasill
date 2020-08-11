docker = docker-compose run --rm
project = here_node

include makefiles/prisma.mk
include makefiles/npm.mk
include makefiles/nestjs.mk
include makefiles/k8s.mk
include makefiles/grpc.mk