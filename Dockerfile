FROM python:3.7

WORKDIR /app

ENV PYTHONPATH /app/app

COPY requirements.txt .
RUN pip install -r requirements.txt
