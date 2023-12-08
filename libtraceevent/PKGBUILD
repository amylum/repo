# Maintainer: David Runge <dvzrv@archlinux.org>

pkgbase=libtraceevent
pkgname=(
  libtraceevent
  libtraceevent-docs
)
pkgver=1.7.3
pkgrel=1
epoch=1
pkgdesc="Linux kernel trace event library"
arch=(x86_64)
url="https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/about/"
license=(GPL2 LGPL2.1)
makedepends=(
  asciidoc
  xmlto
)
source=(
  $pkgname-$pkgver.tar.gz::https://git.kernel.org/pub/scm/libs/libtrace/$pkgname.git/snapshot/$pkgname-$pkgver.tar.gz
  $pkgname-1.5.0-documentation.patch
)
sha512sums=('81302cb24a3fc71e8bd6a0ba975a2699eaa629ac0e90837bf8fc8e23e04156827d19b25544cdb506b0bf76d5f08699264c9ecb979f9218bdee6b0b0e7339b1e0'
            '74b34a722d3fb9d672826e0b6b137f94a7fcd41bb372f8944bb6a0c652c0e725aaef8e95284fc091c2e9954bcf1656b5428d7e0f121682d40c25623178ee4a1e')
b2sums=('dcbca01f2246045f4f2377f91118e2468bca4344686b9e0349d04270543fea5648d5c227bdaf6e716d623bab8d03cec7a869bf67d03ca6a7836014854bbe40b8'
        'f66f4f20dfe562407a0d4bb53785d1515c4b5f4be64dd96e06ea6c9e03c299b2f0f613901c30893a976b3874d13e768791632a7cb89be92f3788330e4f5ab97d')

_pick() {
  local p="$1" f d; shift
  for f; do
    d="$srcdir/$p/${f#$pkgdir/}"
    mkdir -p "$(dirname "$d")"
    mv "$f" "$d"
    rmdir -p --ignore-fail-on-non-empty "$(dirname "$f")"
  done
}

prepare() {
  patch -d $pkgname-$pkgver -p1 -i ../$pkgname-1.5.0-documentation.patch
}

build() {
  make -C $pkgname-$pkgver
  make -C $pkgname-$pkgver/Documentation
}

package_libtraceevent() {
  depends=(glibc)
  optdepends=('libtraceevent-docs: for documentation')
  provides=(libtraceevent.so)

  make libdir_relative=lib prefix=/usr DESTDIR="$pkgdir/" install -C $pkgname-$pkgver
  make libdir_relative=lib prefix=/usr DESTDIR="$pkgdir/" install -C $pkgname-$pkgver/Documentation
  (
    cd "$pkgdir"
    _pick libtraceevent-docs usr/share/doc
  )
}

package_libtraceevent-docs() {
  pkgdesc+=" - documentation"

  mv -v $pkgname/* "$pkgdir"
}
