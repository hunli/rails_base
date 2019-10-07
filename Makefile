enter:
	docker-compose run web bash

dbinit:
	docker-compose run web rake db:create
	migrate
	seed

migrate:
	docker-compose run web rake db:migrate

seed:
	docker-compose run web rake db:seed

rebuild:
	docker-compose up -d --build

rebuild-hard:
	docker-compose run web bundle install
	docker-compose up -d --build

restart:
	docker-compose up -d

start:
	docker-compose up -d

stop:
	docker-compose down
