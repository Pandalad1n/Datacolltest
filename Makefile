IMAGE = datacoll
CONTAINER = datacoll
DB_PATH = /var/data/sitedb.db

start: build worker

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: worker
worker:
	mkdir ./.log/ || true
	touch ./.log/cron.log
	docker run \
		-v `pwd`/.data:/var/data \
		-v `pwd`/.log/cron.log:/var/log/cron.log \
		-d \
		--name $(CONTAINER) \
		--rm \
		$(IMAGE)

.PHONY: stop
stop:
	docker stop $(CONTAINER)

.PHONY: dbshell
dbshell:
	docker run -v `pwd`/.data:/var/data -ti --rm $(IMAGE) sqlite3 $(DB_PATH)

.PHONY: initdb
initdb:
	docker run -v `pwd`/.data:/var/data -i --rm $(IMAGE) sqlite3 $(DB_PATH) < init.sql

.PHONY: addsites
addsites:
	docker run -v `pwd`/.data:/var/data -i --rm $(IMAGE) sqlite3 $(DB_PATH) < add_new_sites.sql