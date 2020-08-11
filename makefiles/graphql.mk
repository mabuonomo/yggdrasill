graphql_build:
	# cd ./graphql && 
	${docker} ${container} npm ci && \
	${docker} ${container} ts-node /graphql/generate-typings