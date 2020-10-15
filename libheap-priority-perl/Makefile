.PHONY: build clean

all: clean build

build:
	@echo "==> Building image..."
	docker build -t heap-priority-builder:latest .
	@echo "==> Extracting build artefacts..."
	docker run --rm -v ${PWD}/deb:/deb crypt-idea-builder:latest
clean:
	@echo "==> Removing any old artefacts..."
	rm deb/* || echo "==> No artefacts found."
	@echo "==> Removing any old Docker images..."
	docker image rm heap-priority-builder || echo "==> No images found."
