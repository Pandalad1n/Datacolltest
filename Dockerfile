FROM python:3.7

RUN apt-get update \
 && apt-get -y install sqlite3 cron \
 && apt-get clean

WORKDIR /app

ENV PYTHONPATH /app/app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
COPY cron_app /etc/cron.d/cron_app

RUN chmod 0644 /etc/cron.d/cron_app
RUN crontab /etc/cron.d/cron_app
RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log
