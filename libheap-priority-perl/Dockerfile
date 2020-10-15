FROM debian:buster
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
RUN dh-make-perl --cpan Heap::Priority
WORKDIR /build/libheap-priority-perl
RUN dpkg-buildpackage
WORKDIR /build
CMD ["sh", "-c", "/bin/mv libheap-priority-perl*.deb /deb"]
