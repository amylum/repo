CONFIG_FILE = .conf

SHELL = /usr/bin/env bash

PACKAGES = $(shell find * -name PKGBUILD -exec dirname {} \;)
BUILD_PACKAGES = $(addprefix build-,$(PACKAGES))
UPLOAD_PACKAGES = $(addprefix upload-,$(PACKAGES))

define s3repo
source $(CONFIG_FILE) && s3repo $1 $2
endef

.PHONY : default build-all upload-all clean $(PACKAGES) $(BUILD_PACKAGES) $(UPLOAD_PACKAGES)

default: build-all upload-all

build-all:
	$(call s3repo,build,$(PACKAGES))

upload-all:
	$(call s3repo,upload,$(PACKAGES))

clean:
	find . -mindepth 2 -maxdepth 2 ! -name PKGBUILD ! -name '*.install' ! -path './.git/*' -print -exec rm -r {} \;

prune:
	$(call s3repo,prune)

$(PACKAGES):
	$(MAKE) build-$@
	$(MAKE) upload-$@

$(BUILD_PACKAGES):
	$(call s3repo,build,$(subst build-,,$@))

$(UPLOAD_PACKAGES):
	$(call s3repo,upload,$(subst upload-,,$@))

