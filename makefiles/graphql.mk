graphql_build:
	cd ./graphql && \
	${docker} generic npm install && \
	${docker} generic ts-node ./generate-typings