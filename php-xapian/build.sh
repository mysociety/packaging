#!/bin/bash

DIST=${1:-buster}

echo "==> Building docker image..."
docker build -f Dockerfile.${DIST} -t php-xapian-builder:latest .

if [ $? -ne 0 ]; then
  echo "==> Build Failed, aborting."
  exit 1
fi

echo "==> Building software..."
mkdir -p deb/${DIST}
docker run -v ${PWD}/deb:/home/builder/deb php-xapian-builder:latest
