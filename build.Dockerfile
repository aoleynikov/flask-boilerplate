FROM python:3.6

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV DOCKER_HOST=unix:///var/run/docker.sock
ENV DEBIAN_FRONTEND=noninteractive

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=us-east-2
ENV AWS_DEFAULT_OUTPUT=text

RUN apt-get update && apt-get install -y curl && \
    curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    apt-get install -y docker-compose && \
    pip install awscli

RUN aws configure list