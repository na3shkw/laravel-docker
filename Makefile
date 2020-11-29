SHELL=/bin/bash

build:
	docker-compose build
up:
	docker-compose up -d
down:
	docker-compose down
stop:
	docker-compose stop
init:
	./update-uid.sh
restart:
	@make down
	@make up
bash:
	docker-compose exec -u devuser -e TERM=xterm-256color -e SHELL=/bin/bash php bash
bashroot:
	docker-compose exec -e TERM=xterm-256color -e SHELL=/bin/bash php bash
