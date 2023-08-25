PACKAGE_NAMES := $(shell ./scripts/names.rb)
PACKAGE_FILES := $(shell ./scripts/files.rb)

BUILD_PACKAGES := $(addprefix build-,$(PACKAGE_NAMES))
CHECK_PACKAGES := $(addprefix check-,$(PACKAGE_NAMES))
UPLOAD_PACKAGES := $(addprefix upload-,$(PACKAGE_NAMES))

DOCKER_CMD = docker run \
	--rm -t -i \
	-e AWS_ACCESS_KEY_ID \
	-e AWS_SECRET_ACCESS_KEY \
	-v $$(pwd):/opt/build \
	-v $$(pwd)/.octoauth.yml:/home/build/.octoauth.yml \
	-v ~/.gnupg:/home/build/.gnupg \
	ghcr.io/amylum/build:latest

S3REPO ?= s3repo
BUILD = source ./makepkg.conf && $(S3REPO) build
UPLOAD = $(S3REPO) upload

NAMCAP ?= namcap

.PHONY : default clean prune $dd(BUILD_PACKAGES) build-all $(UPLOAD_PACKAGES) upload-all $(PACKAGE_NAMES) manual docker-build docker-upload docker-build-all docker-upload-all

##
## Misc. targets
##

# Defaults to building all packages with Docker
default: docker-build

# Clean any package cruft
clean:
	find . -mindepth 2 -maxdepth 2 \
		! -name PKGBUILD \
		! -name '*.install' \
		! -path './.git/*' \
		! -path './templates/*' \
		! -path './scripts/*' \
		-print -exec rm -r {} \;

# Prune package files from the S3 bucket that are no longer in the package DB
prune:
	$(S3REPO) prune

# Launch the docker container with a bash shell
manual:
	$(DOCKER_CMD) bash

# Build, check, and upload an individual package
$(PACKAGE_NAMES): 
	$(MAKE) build-$@ check-$@ upload-$@

##
## Build packages from PKGBUILDs
## Supports individual packages, all, and building in a docker container
##

$(PACKAGE_FILES):
	$(BUILD) $(shell ./scripts/names.rb $@)

$(BUILD_PACKAGES):
	$(MAKE) $(shell ./scripts/files.rb $(subst build-,,$@))

build-all: $(PACKAGE_FILES)

docker-build:
	$(DOCKER_CMD) make build-all

##
## Check packages with namcap
## Supports individual packages, all, and checking in a docker container
##

$(CHECK_PACKAGES):
	$(MAKE) $(subst check-,build-,$@)
	$(NAMCAP) $@/PKGBUILD $@/*.pkg.tar.xz

check-all: $(CHECK_PACKAGES)

docker-check:
	$(DOCKER_CMD) make check-all

##
## Upload packages to S3
## Supports individual packages, all, and uploading from a docker container
##

$(UPLOAD_PACKAGES):
	$(UPLOAD) $(subst upload-,,$@)

upload-all: build-all
	$(UPLOAD) $(PACKAGE_NAMES)

docker-upload:
	$(DOCKER_CMD) make upload-all
