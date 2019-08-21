IMAGE = datacoll
DB_PATH = /var/data/sitedb.db

start: build worker

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: worker
worker:
	docker run \
		-v `pwd`/.data:/var/data \
		--rm \
		-e DB_PATH=$(DB_PATH) \
		$(IMAGE)

.PHONY: stop
stop:
	docker stop

.PHONY: dbshell
dbshell:
	docker run -v `pwd`/.data:/var/data -ti --rm $(IMAGE) sqlite3 $(DB_PATH)

.PHONY: initdb
initdb:
	docker run -v `pwd`/.data:/var/data -i --rm $(IMAGE) sqlite3 $(DB_PATH) < init.sql