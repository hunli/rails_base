bundle:
	docker-compose run web bundle install

enter:
	docker-compose run web bash

dbinit: create migrate seed

create:
	docker-compose run web rake db:create

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
