schemaPath = ./prisma/schema/schema.prisma

prisma_generate:
	${docker} ${container} ./node_modules/.bin/prisma generate --schema ${schemaPath}

prisma_migrate:
	${docker} ${container} ./node_modules/.bin/prisma migrate save --experimental --schema ${schemaPath}
	${docker} ${container} ./node_modules/.bin/prisma migrate up --experimental --schema ${schemaPath}