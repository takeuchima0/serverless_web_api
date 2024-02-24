.PHONY: api up down
api:
	air -c .air.toml

up:
	docker-compose -f docker-compose.yml up -d
	docker-compose -f docker-compose.yml logs -f

down:
	docker-compose -f docker-compose.yml down
