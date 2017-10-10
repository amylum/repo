PACKAGE_NAMES := $(shell ./scripts/names.rb)
PACKAGE_FILES := $(shell ./scripts/files.rb)

BUILD_PACKAGES := $(addprefix build-,$(PACKAGE_NAMES))
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

OUTDATED = $$(cat .outdated)

.PHONY : default clean prune $(BUILD_PACKAGES) build-all build-outdated $(UPLOAD_PACKAGES) upload-all upload-outdated $(PACKAGE_NAMES) manual docker-build docker-upload

default: docker-build

clean:
	find . -mindepth 2 -maxdepth 2 \
		! -name PKGBUILD \
		! -name '*.install' \
		! -path './.git/*' \
		! -path './templates/*' \
		! -path './scripts/*' \
		-print -exec rm -r {} \;
	rm -f .outdated

prune:
	$(S3REPO) prune

manual:
	$(DOCKER_CMD) bash

docker-build:
	$(DOCKER_CMD) make build-outdated

docker-upload:
	$(DOCKER_CMD) make upload-outdated

.outdated:
	./scripts/outdated.rb | tee .outdated

build-outdated: .outdated
	if [[ -s .outdated ]] ; then $(MAKE) $$(cat .outdated) ; fi

upload-outdated: .outdated
	if [[ -s .outdated ]] ; then $(UPLOAD) $$(cat .outdated) ; fi

$(PACKAGE_NAMES): build-$@ upload-$@

build-all: $(PACKAGE_FILES)

upload-all: build-all
	$(UPLOAD) $(PACKAGE_NAMES)

$(UPLOAD_PACKAGES):
	$(UPLOAD) $(subst upload-,,$@)

$(BUILD_PACKAGES):
	$(MAKE) $(shell ./scripts/files.rb $(subst build-,,$@))

$(PACKAGE_FILES):
	$(BUILD) $(shell ./scripts/names.rb $@)

