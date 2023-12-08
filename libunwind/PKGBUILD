# Maintainer: Felix Yan <felixonmars@archlinux.org>
# Contributor: Sébastien Luttringer
# Contributor: Lawrence Lee <valheru@facticius.net>
# Contributor: Phillip Marvin <phillip.marvin@gmail.com>
# Contributor: keystone <phillip.marvin@gmail.com>

pkgname=libunwind
pkgver=1.7.2
pkgrel=1
pkgdesc="Determine and manipulate the call-chain of a program"
url="https://www.nongnu.org/libunwind/"
arch=(x86_64)
license=(GPL)
depends=(
  glibc
  xz
  zlib
)
makedepends=(texlive-binextra)
provides=(
  libunwind-{coredump,ptrace,setjmp,x86_64}.so
  libunwind.so
)
source=(
  https://github.com/libunwind/libunwind/releases/download/v$pkgver/libunwind-$pkgver.tar.gz{,.asc}
)
b2sums=('519570a02d06ce4a174ca226941e493499054112de1c92938434e9fb56fabc8446f699a886ea8beee672ac5e28acd03d16169257a43e2ee1bab084fb331ef4cf'
        'SKIP')
validpgpkeys=(
  F86EB09F72717426F20D36470A0FF845B7DB3427  # Stephen M. Webb <stephen.webb@bregmasoft.ca>
)

prepare() {
  cd libunwind-$pkgver
}

build() {
  local configure_options=(
    --prefix=/usr
    --sysconfdir=/etc
    --localstatedir=/var
  )

  cd libunwind-$pkgver
  ./configure "${configure_options[@]}"
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
  make
}

check() {
  cd libunwind-$pkgver
  make check
}

package() {
  cd libunwind-$pkgver
  make DESTDIR="$pkgdir" install
}

# vim:set sw=2 sts=-1 et:
