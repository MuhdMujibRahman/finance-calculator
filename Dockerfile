# syntax=docker/dockerfile:1
FROM python:3.10.5-alpine3.16

COPY requirements.txt /code/
COPY . /code/
WORKDIR /code

RUN apk add --no-cache --upgrade bash

RUN \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirements.txt --no-cache-dir && \
 apk --purge del .build-deps

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1


ENTRYPOINT [ "bash","src/entrypoint.sh" ]