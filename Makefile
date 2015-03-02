MAKEPKG_CONF = ../makepkg.conf
AWS_CONFIG_FILE = .aws

.PHONY : default clean

default: build upload

build:
	source $(AWS_CONFIG_FILE) && MAKEPKG_CONF=$(MAKEPKG_CONF) s3repo build

upload:
	source $(AWS_CONFIG_FILE) && s3repo upload

clean:
	find . -mindepth 2 -maxdepth 2 ! -name PKGBUILD ! -path './.git/*' -delete

