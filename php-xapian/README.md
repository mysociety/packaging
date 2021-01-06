# PHP7 Bindings for Xapian

This builds the [PHP7 bindings for Xapian](https://xapian.org/docs/bindings/php7/).

Running `build.sh` will default now to building packages for Debian Buster. Stretch is still supported, run `build.sh stretch`.

The default Stretch repositories have Xapian 1.4.3 but don't include a package with the PHP bindings for licensing reasons. This version has [a bug that causes segfaults](https://trac.xapian.org/ticket/748), so we build against 1.4.9 which is available from Stetch Backports.

The bindings for Stretch are built using the `xapian-bindings` source archives downloaded from snapshot.debian.org rather than installing directly using `apt-get source` to ensure we get a matching version. Buster simply uses the default matching version.

This process is handled in a Docker container, built with the `Dockerfile` in this directory. Running `./build.sh` will build the container, then run it and output the debian packages into `./deb/$(lsb_release -cs)/`. Output is printed to STDOUT, so you can see what's going on.

## Manual Build

This can be inferred from `build.sh`, with some slight changes:

First, build a Docker image from the desired `Dockerfile`:
```
docker build -f Dockerfile.buster -t php-xapian-builder:latest .
```

Second, run a container interactively, bind-mounting `deb/` into the container:
```
docker run -it -v ${PWD}/deb:/home/builder/deb php-xapian-builder /bin/bash
```

Then you'll be able build manually by running the build script inside the container:
```
./build-packages
```
