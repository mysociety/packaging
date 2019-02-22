#!/bin/bash

echo "==> Building docker image..."
docker build -t php-xapian-builder:latest .

echo "==> Building software..."
docker run -v ${PWD}/deb:/home/builder/deb php-xapian-builder:latest

