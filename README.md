repo
======

[![Build Status](https://img.shields.io/circleci/project/amylum/repo/master.svg)](https://circleci.com/gh/amylum/repo)
[![Automated Build](https://img.shields.io/docker/build/amylum/repo.svg)](https://hub.docker.com/r/amylum/repo/)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Repository for Arch packages built against [musl](http://www.musl-libc.org/)

## Configuration

The configuration for this lives in the `config.yaml` file, which is used by [s3repo](https://github.com/amylum/s3repo)

## Usage

To build and upload all outdated packages:

```
make docker-build
make docker-upload
```

You can spawn the build container with `make manual`. Other build options can be found in the `Makefile`

## License

These scripts are released under the MIT License. See the bundled LICENSE file for details. The packages being built maintain their upstream licenses, obviously, and their license files are included in each package.

