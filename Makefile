docker = docker-compose run 
container = utils

include makefiles/prisma.mk
include makefiles/npm.mk
include makefiles/nestjs.mk
include makefiles/k8s.mk
include makefiles/grpc.mk
include makefiles/graphql.mk