# Maintainer: Robin Broda <coderobe @ archlinux.org>
# Contributor: Brian Bidulock <bidulock@openss7.org>
# Contributor: Patryk Kowalczyk < patryk at kowalczyk dot ws>

pkgname=hivex
pkgver=1.3.23
pkgrel=3
pkgdesc="System for extracting the contents of Windows Registry."
arch=("x86_64")
url="http://libguestfs.org"
license=("LGPL2.1")
depends=("libxml2" "perl")
makedepends=("python" "ruby" "ruby-rake" "ruby-rdoc" "perl-io-stringy" "perl-test-simple" "ocaml-findlib" "ocaml" "ocaml-compiler-libs" "chrpath")
optdepends=("python: python bindings"
	    "ruby: ruby bindings"
	    "ocaml: ocaml bindings")
source=("https://download.libguestfs.org/hivex/$pkgname-$pkgver.tar.gz"{,.sig})
sha512sums=('068fe81a442c8045bf9d98f0c6b782330141d8f1e104a0f191c04a2cff25ee6396c2c4777c107d595a471eb4bcbee903400c9f7946cae036165ac201587f861e'
            'SKIP')
validpgpkeys=('F7774FB1AD074A7E8C8767EA91738F73E1B768A0') # Richard W.M. Jones <rjones@redhat.com>

build() {
    cd "$pkgname-$pkgver"

    CFLAGS+=' -ffat-lto-objects' \
    ./configure \
	--bindir=/usr/bin \
	--libdir=/usr/lib \
	--prefix=/usr \
	--disable-rpath \
	--disable-static PYTHON=python

    make
    chrpath -d perl/blib/arch/auto/Win/Hivex/Hivex.so
}

package() {
    cd "$pkgname-$pkgver"
    make DESTDIR="$pkgdir" install
}
