#!/bin/bash

DIST=${1:-buster}
SOFTWARE=$(basename $(pwd))

echo "==> Building docker image..."
docker build -f Dockerfile.${DIST} -t ${SOFTWARE}-builder:latest .

if [ $? -ne 0 ]; then
  echo "==> Build Failed, aborting."
  exit 1
fi

echo "==> Extracting ${SOFTWARE}..."
mkdir -p deb/${DIST}
docker run --rm -v ${PWD}/deb:/home/builder/deb ${SOFTWARE}-builder:latest
