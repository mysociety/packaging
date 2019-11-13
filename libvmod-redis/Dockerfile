FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV VARNISHAPI_VMODDIR=/usr/lib/x86_64-linux-gnu/varnish/vmods/
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

RUN git clone https://github.com/sagepe/libvmod-redis.git \
      && cd libvmod-redis \
      && git checkout origin/stretch \
      && ./autogen.sh \
      && debuild -e VARNISHAPI_VMODDIR --no-tgz-check -us -uc 
      
CMD /bin/cp /home/builder/*.deb /deb
