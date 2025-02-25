# Debian Packaging

This repository contains scripts to build various Debian packages used
by some of our software or internally at mySociety.

The builds are completed in Docker containers for each target platform
where a full build is required; simpler binary or file packages are
usually built only once.

These packages do not always conform to official Debian build standards!
As noted, they are often used internally. Use these at your own risk.

## Setup

After a fresh clone or a pull, run `script/update` as usual. This will
call `script/bootstrap` to do some checks, then seed the necessary
helper scripts and build the configuration files needed from their
templates ready to go.

For a manual approach, you can run `./configure` in any image or package
build directory to build the current set of files necessary to complete a
build. This includes a `Makefile`, so you can follow the familiar approach
of running `./configure` followed by `make` to build things - but see
below for more details.

## Building existing packages

You'll want to build at least `images/base` before starting on any of
the packages, as these all use this as their base image.

In each image or package directory, running `./configure` should set up
the local environment, then `make` will build all the systems targeted
by the build in question. The Debian package files will be placed under
the local `deb/` directory, either in subdirectories for each target's
codename (e.g. "stretch", etc) or in an "all" subdirectory for generic
packages.

The `Makefile` includes targets for each individual target system, so you
can also run things like `make buster` or `make focal` to build those if
you want, and while testing the integration of a new target system.

### Targeting an architecture

Some packages let you specify the architecture to build against, in
case it has native dependencies and your host machine's arch
(which is what will be used when building, by default) doesn't match up
with the arch you'll be installing the package on.

This feature makes use of
[Docker's multi-platform builds](https://docs.docker.com/build/building/multi-platform/).
You may need to do some set-up (such as switching to the `containerd`
image store) to get this working for you - the docs are very
helpful here.

Once done, you will need to build the `images/base` for the codename and
architecture you're targeting, for example `make buster-amd64` or,
for all distributions `make all-amd64`. And then do the same
in the package directory.

## How it works

The builds are completed in Docker containers and the Debian packages
created using [`fpm`](https://github.com/jordansissel/fpm) or the native
Debian tools where possible.

The `images/` directory contains configuration for the base images that
contain development tools, etc, needed for most of the package builds.
Before you start, you'll want to build at least `images/base`.

The builds use a system of Jinja2 templates and YAML configuration files
to make adding new target systems more straightforward and to standardise
the way we configure, document and build packages.

Target systems are listed in `distributions.yaml`, architectures in
`architectures.yaml` and global variables in `globals.yaml`.

Individual builds for base images and packages can extend and override
these values in their local `conf/conf.yaml` file, relative to their
subdirectory. These variables can then be used in Jinja2 templates.

The initial templates can be found under `templates/`, baase images with
various build tools and shared configuration are built from subdirectories
of `images/` and packages are under `packages/`.

There are some shared helper scripts that are currently copied into each
build's `bin/` directory and excluded from git in that location. These
should only be modified globally and updated via `script/update`.

Most of the other templated files are intended to be locally modified and
committed directly, with some caveats.

`configure`
: This must at least retain what's in the template, but arbitrary other
things can be added.

`bin/build.sh`
: This script is called from the generated `Makefile` to perform the
actual build for a given target system. It's a shared script, and
shouldn't be edited in each build directory.

`bin/configure.py`
: This script is called by `./configure`, loads up the YAML config data
and generates the required configuration files from the Jinja2 templates.
It's a shared script, and shouldn't be edited in each build directory.

`conf/Makefile.j2`
: This must retain compatibility with the `bin/build.sh` script; it's
mainly intended to allow for additional custom tagrets and local
requirements in the `clean-config` target.

`conf/Dockerfile.j2`
: This is where the heavy-lifting takes place, and should be where the
build is documented.

`conf/conf.yaml`
: This is for local configuration variables, which can override the ones
from the global level.

### Creating a new build

New images or builds can be seeded by running `bin/setup-build <package name>`
or `bin/setup-image <image name>`. This will set-up the initial skeleton
directory with the basic files.

You'll then need to edit the templates and configuration until you have
something that works, then you can commit the new config.

You can add anything you need here, including files or directories to
include in the build (e.g. a `debian` directory for a fully-conformant
package), any extra helper scripts, etc.

#### Excluding a particular target system

Although the global `distributions.yaml` file contains all the Debian
and Ubuntu versions we'd ideally like to support, sometimes we may not
wish to do so for a particular build - especially as systems get near
to end-of-life software builds start to fail due to out-dated libraries,
etc.

The `skip_codenames` array can be used in a build's `conf/conf.yaml` to
skip past a given system.

#### Building a single package for all systems

Not all packages contain software that has to be compiled and built for
a specific release - some are just collections of files or standalone
binaries without external dependencies. In these cases, building multiple
packages is just a waste of time.

In these cases, set `shared_package: true` in the local `conf/conf.yaml`
and a single package will be created. You'll still need to select a
particular build image to use.

### Adding a new target system

* Add the new target system to `distributions.yaml`
* Run `script/update`
* Ensure you can build `images/base` for the new target system
* Test each package build against the new target system, fixing bugs
as you go.
