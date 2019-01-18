#!make

include .env

APP_NAME=storytelling-example

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
IMAGE="877366825671.dkr.ecr.us-east-1.amazonaws.com/$(APP_NAME):$(ENV)"
ECR_REPO_URL='877366825671.dkr.ecr.us-east-1.amazonaws.com'

tag:
	docker tag $(ENV):latest $(IMAGE)

push:
	docker push $(IMAGE)

pull:
	docker pull $(IMAGE)

deploy:
	ansible-playbook -i deploy/group_vars/server -s deploy/deploy.yml --extra-vars 'docker_image=$(IMAGE) aws_key=$(AWS_ACCESS_KEY_ID) aws_secret=$(AWS_SECRET_ACCESS_ID) version=$(ENV)'