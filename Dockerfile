FROM python:3.7

RUN apt-get update \
 && apt-get install sqlite3 \
 && apt-get clean

WORKDIR /app

ENV PYTHONPATH /app/app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .