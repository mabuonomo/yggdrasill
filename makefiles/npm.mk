npm_init:
	if [ -d "./node_modules" ]; then echo "node_modules found"; else ${docker} ${container} npm install; fi
	
npm_format:
	${docker} ${container} npm run format
	${docker} ${container} npm run lint:fix

npm_update:
	${docker} ${container} ncu -u
	${docker} ${container} npm install



