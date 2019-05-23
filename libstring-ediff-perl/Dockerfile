FROM debian:stretch
MAINTAINER sysadmin@mysociety.org

ENV DEBIAN_FRONTEND noninteractive
ENV DEBEMAIL sysadmin@mysociety.org
ENV DEBFULLNAME mySociety
ENV SOURCE_VERSION 0.10

RUN apt-get update && \
      apt-get install -y \
        build-essential \
        dh-make-perl \
        swig \
        wget

RUN mkdir /build
WORKDIR /build
RUN wget https://github.com/mysociety/String-Ediff/archive/v${SOURCE_VERSION}.tar.gz \
      -O libstring-ediff-perl_${SOURCE_VERSION}.orig.tar.gz && \
      tar xf libstring-ediff-perl_${SOURCE_VERSION}.orig.tar.gz

WORKDIR /build/String-Ediff-${SOURCE_VERSION}
RUN dh-make-perl && dpkg-buildpackage

WORKDIR /build

CMD ["sh", "-c", "/bin/mv libstring-ediff-perl*_${SOURCE_VERSION}-1* /deb"]
