.PHONY: all stretch buster

all: stretch buster

stretch:
	@echo "==> Building Stretch..."
	@./build.sh stretch

buster:
	@echo "==> Building Buster..."
	@./build.sh buster

clean:
	@echo "==> Removing old artefacts..."
	@rm -fr deb/* || echo "==> No artefacts found."
	@echo "==> Removing old Docker images..."
	@docker image rm $(shell basename $(shell pwd))-builder 2>/dev/null || echo "==> No images found."
