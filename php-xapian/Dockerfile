FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ARG SOURCE_URL=https://snapshot.debian.org/archive/debian/20181104T030400Z/pool/main/x/xapian-bindings

COPY sources.list /etc/apt/sources.list

RUN adduser --shell /bin/bash --disabled-password --gecos "" builder

RUN apt-get -qq update \
      && apt-get install -y \
        build-essential \
        ca-certificates \
        devscripts \
        git \
        php7.0-dev \
        php7.0-cli \
        wget \
      && apt-get -t stretch-backports install -y \
        libxapian-dev

WORKDIR /home/builder
USER builder 

# Get the sources
RUN wget ${SOURCE_URL}/xapian-bindings_1.4.9.orig.tar.xz \
      && wget ${SOURCE_URL}/xapian-bindings_1.4.9-1.debian.tar.xz \
      && wget ${SOURCE_URL}/xapian-bindings_1.4.9-1.dsc \
      && tar xJf xapian-bindings_1.4.9.orig.tar.xz \
      && tar xJf xapian-bindings_1.4.9-1.debian.tar.xz -C xapian-bindings-1.4.9

# Setup
RUN cd xapian-bindings-1.4.9 \
      && echo php7 > debian/bindings-to-package \
      && ./debian/rules maint PHP7_VERSIONS=7.0

COPY build-packages .
CMD /home/builder/build-packages
