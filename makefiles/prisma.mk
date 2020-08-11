schemaPath = ./prisma/schema/schema.prisma

# prisma_install_cli:
# 	${docker} ${container} npm install @prisma/cli --save-dev

prisma_generate:
	${docker} ${container} ./node_modules/.bin/prisma generate --schema ${schemaPath}

prisma_migrate:
	${docker} ${container} ./node_modules/.bin/prisma migrate save --experimental --schema ${schemaPath}
	${docker} ${container} ./node_modules/.bin/prisma migrate up --experimental --schema ${schemaPath}