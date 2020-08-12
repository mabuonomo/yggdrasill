nest_start:
	@${dockerMain} --service-ports ${container} npm run start

nest_debug:
	@${dockerMain} --service-ports ${container} npm run start:debug

nest_test:
	@${dockerMain} ${project} npm run test