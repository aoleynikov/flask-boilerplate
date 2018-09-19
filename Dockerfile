FROM python:3.7-alpine3.8

RUN mkdir /app
WORKDIR /app

COPY . .
RUN pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT gunicorn -w 4 -b:8000 --access-logfile - app:app