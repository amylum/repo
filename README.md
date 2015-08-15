repo
======

[![Automated Build](http://img.shields.io/badge/automated-build-green.svg)](https://hub.docker.com/r/amylum/repo/)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Repository for Arch packages, primarily compiled statically and built against [musl](http://www.musl-libc.org/)

## Configuration

This uses `./.conf` file, which is sourced to populate environment variables. Here's a sample config:

```
export AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAAAAAAA
export AWS_SECRET_ACCESS_KEY=BBBBBBBBBBBBBBBBBBBBBBBBBB
export AWS_REGION=us-east-1
export S3_BUCKET=amylum
export MAKEPKG_FLAGS="--force --nodeps --clean"
export MAKEPKG_CONF=../makepkg.conf
```

The first 4 are used by [s3repo](https://github.com/amylum/s3repo), which is responsible for pushing the packages to S3. The latter 3 are used by makepkg for building packages and signing them.

You'll also need pacman installed, for the actual package making.

## Usage

To build and upload all packages:

```
make
```

To just build, `make build-all`; to just upload, `make upload-all`. Any specific package can be built with `make build-NAME` and uploaded with `make upload-NAME`, and `make clean` will clean up all the build cruft.

## Serving the repo

### Heroku

I serve the repo via [a Heroku application](https://github.com/amylum/server). In theory I could have served from S3 directly, but this gives me some more control over caching and request handling.

## License

These scripts are released under the MIT License. See the bundled LICENSE file for details. The packages being built maintain their upstream licenses, obviously, and their license files are included in each package.

