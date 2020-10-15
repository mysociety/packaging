FROM debian:buster
LABEL maintainer="sysadmin@mysociety.org"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBEMAIL sysadmin@mysociety.org
ENV DEBFULLNAME mySociety

RUN apt-get update && \
      apt-get install -y \
        build-essential \
        dh-make-perl \
        wget \
        libheap-perl

RUN mkdir /build
WORKDIR /build
RUN wget https://cpan.metacpan.org/authors/id/F/FW/FWOJCIK/Heap-Priority-0.11.tar.gz && \
      tar xvf Heap-Priority-0.11.tar.gz
WORKDIR /build/Heap-Priority-0.11
RUN dh-make-perl && \
      sed -i -e 's/defined(@/(@/g' t/complete.t && \
      sed -i '/use vars/a use AutoLoader;' Priority.pm && \
      dpkg-buildpackage -b
WORKDIR /build
CMD ["sh", "-c", "/bin/mv libheap-priority-perl*.deb /deb"]
