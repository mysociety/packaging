#!/bin/bash

echo "==> Building docker image..."
docker build -t php-xapian-builder:latest .

if [ $? -ne 0 ]; then
  echo "==> Build Failed, aborting."
  exit 1
fi

echo "==> Building software..."
docker run -v ${PWD}/deb:/home/builder/deb php-xapian-builder:latest

