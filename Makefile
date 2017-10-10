PACKAGE_NAMES = $(shell ./scripts/names.rb)
PACKAGE_FILES = $(shell ./scripts/files.rb)

BUILD_PACKAGES = $(addprefix build-,$(PACKAGE_NAMES))
UPLOAD_PACKAGES = $(addprefix upload-,$(PACKAGE_NAMES))

DOCKER_CMD = docker run \
	--rm -t -i \
	-v $$(pwd):/opt/build \
	-v $$(pwd)/.octoauth.yml:/home/build/.octoauth.yml \
	-v ~/.gnupg:/home/build/.gnupg \
	-v ~/.aws/config:/home/build/.aws/config \
	amylum/repo

.PHONY : default clean prune $(BUILD_PACKAGES) build-all build-outdated $(UPLOAD_PACKAGES) upload-all upload-outdated $(PACKAGES) manual docker-build docker-upload

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
	s3repo prune

.outdated:
	prospectus | grep '^repo::s3::' | cut -d: -f5 | tee .outdated


$(PACKAGE_FILES):
	source ./makepkg.conf && s3repo build $@

$(BUILD_PACKAGES):
	$(MAKE) $(shell ./scripts/files.rb $@)

build-all: $(PACKAGE_FILES)

build-outdated: .outdated
	$(MAKE) $$(cat .outdated)


$(UPLOAD_PACKAGES):
	s3repo upload $(subst upload-,,$@)

upload-all: build-all
	s3repo upload $(PACKAGE_NAMES)

upload-outdated: .outdated
	s3repo upload $$(cat .outdated)


$(PACKAGES):
	$(MAKE) build-$@
	$(MAKE) upload-$@


manual:
	$(DOCKER_CMD) bash

docker-build:
	$(DOCKER_CMD) make build-outdated

docker-upload:
	$(DOCKER_CMD) make upload-outdated

