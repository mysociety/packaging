FROM debian:stretch
MAINTAINER sysadmin@mysociety.org

ENV DEBIAN_FRONTEND noninteractive
ENV DEBEMAIL sysadmin@mysociety.org
ENV DEBFULLNAME mySociety

RUN apt-get update && \
      apt-get install -y \
        build-essential \
        dh-make-perl \
        wget

RUN mkdir -p /root/.cpan/CPAN
WORKDIR /root/.cpan/CPAN
COPY MyConfig.pm .

RUN mkdir /build
WORKDIR /build
RUN dh-make-perl --cpan Crypt::Idea
WORKDIR /build/libcrypt-idea-perl
RUN dpkg-buildpackage
WORKDIR /build
CMD ["sh", "-c", "/bin/mv libcrypt-idea-perl*.deb /deb"]
