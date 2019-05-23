.PHONY: build clean

all: clean build

build:
	@echo "==> Building image..."
	docker build -t string-ediff-builder:latest .
	@echo "==> Extracting build artefacts..."
	docker run --rm -v ${PWD}/deb:/deb string-ediff-builder:latest
clean:
	@echo "==> Removing any old artefacts..."
	rm deb/* || echo "==> No artefacts found."
	@echo "==> Removing any old Docker images..."
	docker image rm string-ediff-builder || echo "==> No images found."
