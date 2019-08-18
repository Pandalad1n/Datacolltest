IMAGE = datacoll

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: start
start:
	docker run \
	-v `pwd`/.data:/var/data

.PHONY: stop
stop:
	docker stop

.PHONY: dbshell
dbshell:
	docker run -v `pwd`/.data:/var/data -ti --rm $(IMAGE) sqlite3 /var/data/sitedb.db

.PHONY: initdb
initdb:
	docker run -v `pwd`/.data:/var/data --rm $(IMAGE) sqlite3 /var/data/sitedb.db < init.sql