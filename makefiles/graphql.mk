graphql_build: npm_init
	@${docker} ${container} ts-node ./graphql/generate-typings