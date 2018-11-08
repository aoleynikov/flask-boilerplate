#!make

include .env

APP_NAME=example

run:
	docker-compose up

ENV=dev

build:
	docker-compose build

stop:
	docker-compose down

test:
	docker-compose up -d
	docker-compose exec -T web pytest 
	docker-compose down

pull_secrets:
	aws s3 cp s3://storytelling-secrets/$(APP_NAME)/$(ENV)/.env ./secrets/$(ENV)/.env

push_secrets:
	aws s3 cp ./secrets/$(ENV)/.env s3://storytelling-secrets/$(APP_NAME)/$(ENV)/.env

use_secrets:
	cp ./secrets/$(ENV)/.env .

VERSION=latest

tag:
	docker tag storytelling-example:latest 877366825671.dkr.ecr.us-east-1.amazonaws.com/storytelling-example:$(VERSION)

push:
	docker push 877366825671.dkr.ecr.us-east-1.amazonaws.com/storytelling-example:$(VERSION)

pull:
	docker pull 877366825671.dkr.ecr.us-east-1.amazonaws.com/storytelling-example:$(VERSION)
