#!/bin/bash

DIST=${1:-all}
ARCH=${2:-none}
cd "$(dirname "$0")/.."
SOFTWARE=$(basename $(pwd))

if [ "$DIST" == "all" ] ; then
    DOCKERFILE="Dockerfile"
else
    if [ "$ARCH" != "none" ] ; then
        DOCKERFILE="Dockerfile.${DIST}.${ARCH}"
    else
        DOCKERFILE="Dockerfile.${DIST}"
    fi
fi

if [ ! -f "$DOCKERFILE" ]; then
    echo "==> ${DOCKERFILE} not found, skipping."
    exit 0
fi

echo "==> Building docker image..."
if [ -n "$USE_HOST_USER" ]; then
    HOST_UID=$(id -u)
    HOST_GID=$(id -g)
    BUILD_ARGS="--build-arg UID=$HOST_UID --build-arg GID=$HOST_GID"
else
    BUILD_ARGS=""
fi

if [ "$ARCH" == "none" ] ; then
    IMAGE_NAME="${SOFTWARE}-builder:${DIST}-latest"
    BUILD_COMMAND="docker build $BUILD_ARGS -f $DOCKERFILE -t $IMAGE_NAME ."
else
    IMAGE_NAME="${SOFTWARE}-builder:${DIST}-${ARCH}-latest"
    BUILD_COMMAND="docker buildx build $BUILD_ARGS --platform linux/$ARCH -f $DOCKERFILE -t $IMAGE_NAME --load ."
fi
$BUILD_COMMAND

if [ $? -ne 0 ]; then
  echo "==> Build Failed, aborting."
  exit 1
fi

echo "==> Extracting ${SOFTWARE}..."
mkdir -p deb/${DIST}
if [ "$ARCH" == "none" ] ; then
    docker run --rm -v ${PWD}/deb:/home/builder/deb $IMAGE_NAME
else
    docker run --platform linux/$ARCH --rm -v ${PWD}/deb:/home/builder/deb $IMAGE_NAME
fi
