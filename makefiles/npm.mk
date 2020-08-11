npm_init:
	${docker} ${container} npm ci

npm_format:
	${docker} ${container} npm run format
	${docker} ${container} npm run lint:fix

npm_update:
	${docker} ${container} ncu -u
	${docker} ${container} npm install


