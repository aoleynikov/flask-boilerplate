FROM python:3.6

ENV DOCKER_HOST=unix:///var/run/docker.sock
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir ~/.aws
COPY credentials .
COPY config .

RUN cp config ~/.aws && cp credentials ~/.aws && \
    apt-get update && apt-get install -y curl && \
    curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    apt-get install -y docker-compose && \
    pip install awscli 
# aws configure
