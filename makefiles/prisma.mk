schemaPath = /main/schema/prisma/schema.prisma

__prisma_install_cli:
	${dockerMain} ${container} npm list @prisma/cli || ${dockerMain} ${container} npm install @prisma/cli --save-dev

prisma_build: __prisma_install_cli
	${dockerMain} ${container} npx prisma generate --schema ${schemaPath}

prisma_migrate:
	${dockerMain} ${container} npx prisma migrate save --experimental --schema ${schemaPath}
	${dockerMain} ${container} npx prisma migrate up --experimental --schema ${schemaPath}