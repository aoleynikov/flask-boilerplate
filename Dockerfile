FROM python:3.7-alpine3.8

ARG SECRET

RUN mkdir /app
WORKDIR /app

COPY . .
RUN pip install -r requirements.txt

EXPOSE 8000

ENV SECRET=${SECRET}

ENTRYPOINT gunicorn -w 4 -b:8000 --access-logfile - app:app