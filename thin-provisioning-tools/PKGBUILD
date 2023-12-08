# Maintainer: Eric Bélanger <eric@archlinux.org>
# Contributor: Jason Hall <cakersq@gmail.com>

pkgname=thin-provisioning-tools
pkgver=1.0.9
pkgrel=1
pkgdesc='Suite of tools for manipulating the metadata of the dm-thin device-mapper target'
arch=('x86_64')
url='https://github.com/jthornber/thin-provisioning-tools'
license=('GPL3')
depends=('gcc-libs')
makedepends=('cargo')
source=("${pkgname}-${pkgver}.tar.gz::https://github.com/jthornber/${pkgname}/archive/v${pkgver}.tar.gz")
sha256sums=('4ff542b438babf4e17378bc5c6d823ec35c00f72bde49fe229a803bba4634512')

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"

  cargo build --release
}

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"

  make \
    DESTDIR="${pkgdir}"/usr \
    BINDIR="${pkgdir}"/usr/bin \
    DATADIR="${pkgdir}"/usr/share \
    install
}

