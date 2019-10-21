start: build run

build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose kill

destroy:
	docker-compose down

logs:
	docker-compose logs -f web

shell:
	docker exec -it python-web sh

ip:
	docker inspect python-web | grep "IPAddress"

