# PHP7 Bindings for Xapian

This builds the [PHP7 bindings for Xapian](https://xapian.org/docs/bindings/php7/). The default Stretch repositories have Xapian 1.4.3 but don't include a package with the PHP bindings for licensing reasons.

The bindings can be built using the `xapian-bindings` source package, but there are issues with the build scripts in the `debian/` directory that cause the build to fail. These are fixed upstream, so merging some more updated scripts with the 1.4.3 sources permits a successful build that passes the tests.

This process is handled in a Docker container, built with the `Dockerfile` in this directory. Running `./build.sh` will build the container, then run it and output the debian packages into `./deb/`. Output is printed to STDOUT, so you can see what's going on.

## Manual Build

This can be inferred from `build.sh`, with some slight changes:

First, build a Docker image fromt the `Dockerfile`:
```
docker build -t php-xapian-builder:latest .
```

Second, run a container interactively, bind-mounting `deb/` into the container:
```
docker run -it -v ${PWD}/deb:/home/builder/deb php-xapian-builder /bin/bash
```

Then you'll be able build manually by running the build script inside the container:
```
./build-packages
```
