.PHONY: all setup stretch buster xenial bionic focal clean

all: stretch buster xenial bionic focal

setup:
	@./bin/configure.py

stretch: setup
	@echo "==> Building stretch..."
	@./bin/build.sh stretch

buster: setup
	@echo "==> Building buster..."
	@./bin/build.sh buster

xenial: setup
	@echo "==> Building xenail..."
	@./bin/build.sh xenial

bionic: setup
	@echo "==> Building bionic..."
	@./bin/build.sh bionic

focal: setup
	@echo "==> Building focal..."
	@./bin/build.sh focal

clean-deb:
	@echo "==> Removing old artefacts..."
	@rm -fr deb/* || echo "==> No artefacts found."

clean-images:
	@echo "==> Removing old Docker images..."
	@docker image rm $(shell basename $(shell pwd))-builder 2>/dev/null || echo "==> No images found."

clean-config:
	@echo "==> Removing generated Dockerfiles..."
	@rm -f Dockerfile.*

clean: clean-deb clean-images clean-config
