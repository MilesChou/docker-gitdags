#!/usr/bin/make -f
IMAGE := $(shell basename $(shell pwd))
VERSION := latest

.PHONY: all build rebuild shell run

# ------------------------------------------------------------------------------

all: build

build:
	docker build --progress=plain -t=$(IMAGE):$(VERSION) .

rebuild:
	docker build -t=$(IMAGE):$(VERSION) --no-cache .

shell:
	docker run --rm -it -v `pwd`/examples:/tex $(IMAGE):$(VERSION) sh

run:
	docker run --rm -it -v `pwd`/examples:/tex $(IMAGE):$(VERSION)

clean:
	git clean -Xf examples
