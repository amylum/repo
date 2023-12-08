# Maintainer: Levente Polyak <anthraxx[at]archlinux[dot]org>
# Contributor: bitwave <aur [aT] oomlu [d0T] de>
# Contributor: fnord0 <fnord0 AT riseup DOT net>

pkgname=yara
pkgver=4.3.2
pkgrel=1
pkgdesc='Tool aimed at helping malware researchers to identify and classify malware samples'
url='https://github.com/VirusTotal/yara'
arch=('x86_64')
license=('BSD')
depends=('openssl' 'file' libmagic.so)
provides=('libyara.so')
source=(https://github.com/VirusTotal/${pkgname}/archive/v${pkgver}/${pkgname}-${pkgver}.tar.gz)
sha512sums=('dc77ec46a30ca2fff33b639166fc554c9c6d9e955642774e23da3ea7dbb25fe154cfd4ef83c9808920193028b9099258a63b3f1b9a66864a1f3905f0a8e8053f')
b2sums=('cfcc18dbd4c69f5f640ef755a8d4efe5f7ec8e313153955644fbd2adc03d1c73cddc042e95c0c0629fd58780922eb3dc1c72a5ca1bd9ff767a9e3f41f1652c98')

prepare() {
  cd ${pkgname}-${pkgver}
  autoreconf -fiv
}

build() {
  cd ${pkgname}-${pkgver}
  ./configure \
    --prefix=/usr \
    --with-crypto \
    --enable-magic
  make
}

package() {
  cd ${pkgname}-${pkgver}
  make DESTDIR="${pkgdir}" install
  install -Dm 644 COPYING -t "${pkgdir}/usr/share/licenses/${pkgname}"
  install -Dm 644 README.md -t "${pkgdir}/usr/share/doc/${pkgname}"
  cp -r docs "${pkgdir}/usr/share/doc/${pkgname}"
}

# vim: ts=2 sw=2 et:
