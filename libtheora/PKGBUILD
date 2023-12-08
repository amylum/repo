# Maintainer: Balló György <ballogyor+arch at gmail dot com>
# Contributor: Tom Killian <tom@archlinux.org>
# Committer: dorphell <dorphell@archlinux.org>

pkgname=libtheora
pkgver=1.1.1
pkgrel=6
pkgdesc='Standard encoder and decoder library for the Theora video compression format'
arch=('x86_64')
url='https://www.theora.org/'
license=('BSD')
depends=('glibc' 'libogg')
makedepends=('libpng' 'libvorbis' 'sdl')
source=("https://downloads.xiph.org/releases/theora/$pkgname-$pkgver.tar.xz"
        'libtheora-1.1.1-libpng16.patch')
sha256sums=('f36da409947aa2b3dcc6af0a8c2e3144bc19db2ed547d64e9171c59c66561c61'
            'e4c9a8dc798c596ed32a2a720020ae27a0e72f5add1a47cb8fadebe0e7180d7e')

prepare() {
  cd $pkgname-$pkgver
  patch -Np0 -i ../libtheora-1.1.1-libpng16.patch
}

build() {
  cd $pkgname-$pkgver
  ./configure --prefix=/usr
  make
}

check() {
  cd $pkgname-$pkgver
  make check
}

package() {
  cd $pkgname-$pkgver
  make DESTDIR="$pkgdir" install
  install -Dm644 -t "$pkgdir/usr/share/licenses/$pkgname/" LICENSE COPYING
}
