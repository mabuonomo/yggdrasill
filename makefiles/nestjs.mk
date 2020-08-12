nest_start:
	${dockerMain} ${container} npm run start

nest_debug:
	${dockerMain} ${container} npm run start:debug

nest_test:
	${dockerMain} ${project} npm run test