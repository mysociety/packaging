.PHONY: all stretch buster bionic

all: buster stretch bionic

stretch:
	@./build.sh stretch

buster:
	@./build.sh buster

bionic:
	@./build.sh bionic

clean:
	@echo "==> Removing old artefacts..."
	@rm -fr deb/* || echo "==> No artefacts found."
	@echo "==> Removing old Docker images..."
	@docker image rm $(shell basename $(shell pwd))-builder 2>/dev/null || echo "==> No images found."
