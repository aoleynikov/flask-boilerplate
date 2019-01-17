#!make

include .env

APP_NAME=example

hi:
	echo 'Hi~!'

run:
	docker-compose -d up

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
IMAGE_NAME=storytelling-example
ECS_REPO_URL=877366825671.dkr.ecr.us-east-1.amazonaws.com/$(IMAGE_NAME)

echo_image:
	echo $(ECS_REPO_URL)

tag:
	docker tag IMAGE_NAME:latest $(ECS_REPO_URL):$(VERSION)

push:
	docker push $(ECS_REPO_URL):$(VERSION)

pull:
	docker pull $(ECS_REPO_URL):$(VERSION)

remove_image:
	docker rmi $(ECS_REPO_URL):$(VERSION)