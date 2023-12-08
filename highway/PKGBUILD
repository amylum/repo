# Maintainer: Daniel Bermond <dbermond@archlinux.org>

pkgname=highway
pkgver=1.0.7
pkgrel=1
pkgdesc='A C++ library for SIMD (Single Instruction, Multiple Data)'
arch=('x86_64')
url='https://github.com/google/highway/'
license=('Apache')
depends=('gcc-libs')
makedepends=('cmake' 'gtest')
source=("https://github.com/google/highway/archive/${pkgver}/${pkgname}-${pkgver}.tar.gz")
sha256sums=('5434488108186c170a5e2fca5e3c9b6ef59a1caa4d520b008a9b8be6b8abe6c5')

build() {
    cmake -B build -S "${pkgname}-${pkgver}" \
        -G 'Unix Makefiles' \
        -DCMAKE_BUILD_TYPE:STRING='None' \
        -DCMAKE_INSTALL_PREFIX:PATH='/usr' \
        -DBUILD_SHARED_LIBS:BOOL='ON' \
        -DHWY_SYSTEM_GTEST:BOOL='ON' \
        -Wno-dev
    cmake --build build
}

check() {
    ctest --test-dir build --output-on-failure
}

package() {
    DESTDIR="$pkgdir" cmake --install build
}
