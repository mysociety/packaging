# PHP Bindings for Xapian

This builds the [PHP bindings for Xapian](https://xapian.org/docs/bindings/php/) for the systems defined in `conf/conf.yaml`.

It used to be possible to build a Debian package using native Debian tools by using the source packages as described in this [FAQ answer](https://trac.xapian.org/wiki/FAQ/PHP%20Bindings%20Package), but these have not been updated to support PHP 8 as yet, and all newer versions of the bindings since 1.4.22 (the version packaged for Bookworm) require PHP 8.x.

You should now be able to build a suitabale package using the standard method here, so:

 ./configure
 make

To add support for a new release, check the various package versions defined in `conf/conf.yaml` for the distribution and rebuild.
