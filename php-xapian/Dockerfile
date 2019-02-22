FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt/sources.list

RUN adduser --shell /bin/bash --disabled-password --gecos "" builder

RUN apt-get -qq update \
      && apt-get install -y \
        build-essential \
        ca-certificates \
        devscripts \
        git \
        libxapian-dev \
        php7.0-dev \
        php7.0-cli

WORKDIR /home/builder
USER builder 

RUN set -x; \
    mkdir deb; \
    apt-get source xapian-bindings=1.4.3-1; \
    cd xapian-bindings-1.4.3; \
    rm -fr debian/; \
    git clone https://salsa.debian.org/olly/xapian-bindings.git debian; \
    cd debian; \
    git checkout debian/1.4.5-1; \
    git checkout debian/1.4.3-1 changelog; \
    cd ..; \
    echo php7 > debian/bindings-to-package; \
    ./debian/rules maint PHP7_VERSIONS=7.0

COPY build-packages .
CMD /home/builder/build-packages
