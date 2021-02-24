# PHP7 Bindings for Xapian

This builds the [PHP7 bindings for Xapian](https://xapian.org/docs/bindings/php7/), currently targeting version 1.4.18.

This version is available in Buster Backports, but for all other supported systems you'll need to build xapian-core first. There's a recipe for doing that in this repository. We might add the sources to our Debian repository in due course, in which case this build will be updated.

Note that at present, this recipe won't build the PHP bindings for Ubuntu Xenial as the build requires `debhelper-compat (=12)`, which is not easily available for that platform.

The source package for the bindings is downloaded from Debian directly rather than installing directly using `apt-get source` to ensure we get a matching version.
## Procedure

1. If you want the bindings for Debian Stretch or Ubuntu Bionic or Focal, build the required xapian-core packages first, then run `./bin/get-sources` to copy them here.
2. Run `./bin/configure.py` to set up the various Dockerfiles and the Makefile.
3. Run `make` to build the lot, or `make <codename>` to build a particular target build.
