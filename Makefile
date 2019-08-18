IMAGE = datacoll

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: start
start:
	docker run

.PHONY: stop
stop:
	docker stop