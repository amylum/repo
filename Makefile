MAKEPKG_CONF = ../makepkg.conf
AWS_CONFIG_FILE = .aws

PACKAGES = $(shell find * -name PKGBUILD -exec dirname {} \;)
BUILD_PACKAGES = $(addprefix build-,$(PACKAGES))
UPLOAD_PACKAGES = $(addprefix upload-,$(PACKAGES))

define s3repo
source $(AWS_CONFIG_FILE) && MAKEPKG_CONF=$(MAKEPKG_CONF) s3repo $1 $2
endef

.PHONY : default build-all upload-all clean $(BUILD_PACKAGES) $(UPLOAD_PACKAGES)

default: build upload

build-all:
	$(call s3repo,build,$(PACKAGES))

upload-all:
	$(call s3repo,upload,$(PACKAGES))

clean:
	find . -mindepth 2 -maxdepth 2 ! -name PKGBUILD ! -path './.git/*' -print -exec rm -r {} \;

$(BUILD_PACKAGES):
	$(call s3repo,build,$(subst build-,,$@))

$(UPLOAD_PACKAGES):
	$(call s3repo,upload,$(subst upload-,,$@)

