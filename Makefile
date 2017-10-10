PACKAGE_NAMES := $(shell ./scripts/names.rb)
PACKAGE_FILES := $(shell ./scripts/files.rb)

BUILD_PACKAGES := $(addprefix build-,$(PACKAGE_NAMES))
CHECK_PACKAGES := $(addprefix check-,$(PACKAGE_NAMES))
UPLOAD_PACKAGES := $(addprefix upload-,$(PACKAGE_NAMES))

DOCKER_CMD = docker run \
	--rm -t -i \
	-v $$(pwd):/opt/build \
	-v $$(pwd)/.octoauth.yml:/home/build/.octoauth.yml \
	-v ~/.gnupg:/home/build/.gnupg \
	-v ~/.aws/config:/home/build/.aws/config \
	amylum/repo

S3REPO ?= s3repo
BUILD = source ./makepkg.conf && $(S3REPO) build
UPLOAD = $(S3REPO) upload

NAMCAP ?= namcap

OUTDATED = $$(cat .outdated)

define run_outdated
if [[ -s .outdated ]] ; then $1 $$(sed 's/^/$2-/' .outdated) ; fi
endef

.PHONY : default clean prune $dd(BUILD_PACKAGES) build-all build-outdated $(UPLOAD_PACKAGES) upload-all upload-outdated $(PACKAGE_NAMES) manual docker-build docker-upload

##
## Misc. targets
##

# Defaults to building all packages with Docker
default: docker-build

# Clean any package cruft and the .outdated file
clean:
	find . -mindepth 2 -maxdepth 2 \
		! -name PKGBUILD \
		! -name '*.install' \
		! -path './.git/*' \
		! -path './templates/*' \
		! -path './scripts/*' \
		-print -exec rm -r {} \;
	rm -f .outdated

# Prune package files from the S3 bucket that are no longer in the package DB
prune:
	$(S3REPO) prune

# Create the metadata file listing packages where the PKGBUILD is newer than S3
.outdated:
	./scripts/outdated.rb | tee .outdated

# Launch the docker container with a bash shell
manual:
	$(DOCKER_CMD) bash

# Build, check, and upload an individual package
$(PACKAGE_NAMES): 
	$(MAKE) build-$@ check-$@ upload-$@

##
## Build packages from PKGBUILDs
## Supports individual packages, all, outdated, and building in a docker container
##

$(PACKAGE_FILES):
	$(BUILD) $(shell ./scripts/names.rb $@)

$(BUILD_PACKAGES):
	$(MAKE) $(shell ./scripts/files.rb $(subst build-,,$@))

build-all: $(PACKAGE_FILES)

build-outdated: .outdated
	$(call run_outdated,$(MAKE),build)

docker-build:
	$(DOCKER_CMD) make build-outdated

##
## Check packages with namcap
## Supports individual packages, all, outdated, and checking in a docker container
##

$(CHECK_PACKAGES):
	$(MAKE) $(subst check-,build-,$@))
	$(NAMCAP) $@/PKGBUILD $@/*.pkg.tar.xz

check-all: $(CHECK_PACKAGES)

check-outdated:
	$(call run_outdated,$(MAKE),check)

docker-check:
	$(DOCKER_CMD) make check-outdated

##
## Upload packages to S3
## Supports individual packages, all, outdated, and uploading from a docker container
##

$(UPLOAD_PACKAGES):
	$(UPLOAD) $(subst upload-,,$@)

upload-all: build-all
	$(UPLOAD) $(PACKAGE_NAMES)

upload-outdated: .outdated
	$(call run_outdated,$(UPLOAD),upload)

docker-upload:
	$(DOCKER_CMD) make upload-outdated

