CONFIG_FILE = .conf

SHELL = /usr/bin/env bash

PACKAGES = $(shell find * -name PKGBUILD -exec dirname {} \;)
BUILD_PACKAGES = $(addprefix build-,$(PACKAGES))
UPLOAD_PACKAGES = $(addprefix upload-,$(PACKAGES))

DOCKER_CMD = docker run \
	--rm -t -i \
	-v $$(pwd):/opt/build \
	-v $$(pwd)/.octoauth.yml:/root/.octoauth.yml \
	-v ~/.aws/config:/root/.aws/config \
	amylum-repo

define s3repo
source ./makepkg.conf && s3repo $1 $2
endef

.PHONY : default build-all upload-all clean prune build-outdated upload-outdated container docker-build docker-upload $(PACKAGES) $(BUILD_PACKAGES) $(UPLOAD_PACKAGES)

default: build-all upload-all

build-all:
	$(call s3repo,build,$(PACKAGES))

upload-all:
	$(call s3repo,upload,$(PACKAGES))

clean:
	find . -mindepth 2 -maxdepth 2 ! -name PKGBUILD ! -name '*.install' ! -path './.git/*' ! -path './templates/*' -print -exec rm -r {} \;
	rm .outdated

prune:
	$(call s3repo,prune)

.outdated:
	prospectus | grep '^repo::repo' | cut -d: -f5 | tee .outdated

build-outdated: .outdated
	$(call s3repo,build,$$(cat .outdated))

upload-outdated: .outdated
	$(call s3repo,upload,$$(cat .outdated))

container:
	docker build -t amylum-repo .

manual: container
	$(DOCKER_CMD) bash

docker-build: container
	$(DOCKER_CMD) make build-outdated

docker-upload: container
	$(DOCKER_CMD) make upload-outdated

$(PACKAGES):
	$(MAKE) build-$@
	$(MAKE) upload-$@

$(BUILD_PACKAGES):
	$(call s3repo,build,$(subst build-,,$@))

$(UPLOAD_PACKAGES):
	$(call s3repo,upload,$(subst upload-,,$@))

