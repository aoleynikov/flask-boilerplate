#!make

include .env

run:
	docker-compose up

ENV=dev

build:
	docker-compose build

stop:
	docker-compose down

test:
	docker-compose build
	docker-compose up -d
	docker-compose exec web pytest 
	docker-compose down

APP_NAME=example

pull_secrets:
	aws s3 cp s3://storytelling-secrets/$(APP_NAME)/$(ENV)/.env ./secrets/$(ENV)/.env

push_secrets:
	aws s3 cp ./secrets/$(ENV)/.env s3://storytelling-secrets/$(APP_NAME)/$(ENV)/.env

VERSION=latest

tag:
	docker tag storytelling-example:latest 877366825671.dkr.ecr.us-east-2.amazonaws.com/storytelling-example:$(VERSION)

push:
	docker push 877366825671.dkr.ecr.us-east-2.amazonaws.com/storytelling-example:$(VERSION)

pull:
	docker pull 877366825671.dkr.ecr.us-east-2.amazonaws.com/storytelling-example:$(VERSION)
