FROM python:3.6

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_ID
ARG AWS_REGION

ENV DOCKER_HOST=unix:///var/run/docker.sock
ENV DEBIAN_FRONTEND=noninteractive

COPY credentials .
COPY config .

RUN apt-get update && apt-get install -y curl && \
    curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    apt-get install -y docker-compose && \
    pip install awscli
