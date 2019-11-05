FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q && apt-get install -y -qq \
      autotools-dev \
      automake \
      devscripts \
      libtool \
      python-docutils \
      pkg-config \
      libpcre3-dev \
      libeditline-dev \
      libedit-dev \
      make \
      dpkg-dev \
      git \
      libjemalloc-dev \
      libev-dev \
      libncurses-dev \
      python-sphinx \
      graphviz \
      varnish \
      libvarnishapi-dev \
      libhiredis-dev

RUN mkdir /home/builder
WORKDIR /home/builder

RUN git clone https://github.com/carlosabalde/libvmod-redis.git \
      && cd libvmod-redis \
      && git checkout origin/5.0-archived \
      && ./autogen.sh \
      && ./configure \
      && make \
      && debuild --no-tgz-check -us -uc 
      
CMD /bin/cp /home/builder/*.deb /deb
