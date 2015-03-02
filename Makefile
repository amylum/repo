MAKEPKG_CONF = ../makepkg.conf

.PHONY : default clean

default: build upload

build:
	MAKEPKG_CONF=$(MAKEPKG_CONF) s3repo build

upload:
	s3repo upload

clean:
	find . -mindepth 2 -maxdepth 2 ! -name PKGBUILD ! -path './.git/*' -delete

