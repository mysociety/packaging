#/usr/bin/env bash

source ../global.vars
mkdir {deb,source} 2>/dev/null

VERSION=${VERSION:-"1.22.0"}
ITERATION=${ITERATION:-"ms1"}
SOURCE=https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-Linux-x86_64
DEB=docker-compose_${VERSION}-${ITERATION}_amd64.deb
echo "==> Building version ${VERSION}-${ITERATION}..."

if [ -e "deb/${DEB}" ]; then
  echo "==> Existing package found at ./deb/${DEB}".
  exit 1
fi

cd source
if [ -e "docker-compose-Linux-x86_64-${VERSION}" ]; then
  echo "==> Existing download found for ${VERSION}."
  exit 1
else
  curl -L ${SOURCE} -o docker-compose-Linux-x86_64-${VERSION}
  if [ $? -ne 0 ]; then
     echo "==> There was a problem downloading ${SOURCE}."
     exit 2
  fi
fi

chmod +x docker-compose-Linux-x86_64-${VERSION}
cd ..

bundle exec fpm -s dir -t deb \
  --vendor "${VENDOR}" \
  --maintainer "${MAINTAINER}" \
  --version "${VERSION}" \
  --iteration "${ITERATION}" \
  --license 'Apache-2.0' \
  --description "Punctual, lightweight development environments using Docker docker-compose is a service management software built on top of docker. Define your services and their relationships in a simple YAML file, and let compose handle the rest." \
  --url "https://docs.docker.com/compose/" \
  --deb-changelog changelog \
  --after-install postinst \
  --after-remove postrm \
  -p ./deb/ \
  -n "docker-compose" \
  ./source/docker-compose-Linux-x86_64-${VERSION}=/opt/docker/bin/docker-compose
