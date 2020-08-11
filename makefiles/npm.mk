npm_init:
	${docker} ${project} npm install

npm_format:
	${docker} ${project} npm run format
	${docker} ${project} npm run lint:fix

npm_update:
	${docker} ${project} ncu -u
	make npm_init


