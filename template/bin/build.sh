#!/bin/bash

DIST=${1:-all}
cd "$(dirname "$0")/.."
SOFTWARE=$(basename $(pwd))

if [ "$DIST" == "all" ] ; then
    DOCKERFILE="Dockerfile"
else
    DOCKERFILE="Dockerfile.${DIST}"
fi

if [ ! -f "$DOCKERFILE" ]; then
    echo "==> ${DOCKERFILE} not found, skipping."
    exit 0
fi

echo "==> Building docker image..."
docker build -f $DOCKERFILE -t ${SOFTWARE}-builder:${DIST}-latest .

if [ $? -ne 0 ]; then
  echo "==> Build Failed, aborting."
  exit 1
fi

echo "==> Extracting ${SOFTWARE}..."
mkdir -p deb/${DIST}
docker run --rm -v ${PWD}/deb:/home/builder/deb ${SOFTWARE}-builder:${DIST}-latest
