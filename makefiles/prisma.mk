prisma_install:
	${docker} ${project} npm install @prisma/cli --save-dev

prisma_generate:
	${docker} ${project} npx prisma generate --schema ./atena-prisma/prisma/schema.prisma

prisma_migrate:
	${docker} ${project} npx prisma migrate save --experimental --schema ./atena-prisma/prisma/schema.prisma
	${docker} ${project} npx prisma migrate up --experimental --schema ./atena-prisma/prisma/schema.prisma