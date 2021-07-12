FROM leoqbc/php8-lambda-runtime-alpine:latest

COPY ./src /var/task

CMD [ "index" ]