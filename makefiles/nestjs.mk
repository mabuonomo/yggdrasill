nest_start:
	# ${docker} node npm run start
	docker-compose up

nest_debug:
	${docker} ${project}  npm run start:debug

nest_test:
	${docker} ${project}  npm run test