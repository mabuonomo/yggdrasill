nest_start:
	${docker} ${container} node npm run start
	# docker-compose up

nest_debug:
	${docker} ${container} npm run start:debug

nest_test:
	${docker} ${project} npm run test