# Maintainer: Maxime Gauduin <alucryd@archlinux>org>
# Maintainer: quietvoid <tcChlisop0@gmail.com>

pkgname=libdovi
pkgver=3.2.0
pkgrel=2
pkgdesc='Library to read and write Dolby Vision metadata'
arch=(x86_64)
url=https://github.com/quietvoid/dovi_tool/tree/main/dolby_vision
license=(MIT)
depends=(
  gcc-libs
  glibc
)
makedepends=(
  cargo-c
  git
  rust
)
provides=(libdovi.so)
_tag=1971745ca3fc28ace6e9b4e6986aa22d838b66e6
source=(git+https://github.com/quietvoid/dovi_tool.git#tag=${_tag})
b2sums=(SKIP)

prepare() {
  cargo fetch \
    --manifest-path dovi_tool/dolby_vision/Cargo.toml
}

pkgver() {
  cd dovi_tool
  git describe --tags | sed 's/^libdovi-//'
}

build() {
  cargo cbuild \
    --release \
    --frozen \
    --prefix=/usr \
    --manifest-path dovi_tool/dolby_vision/Cargo.toml
}

check() {
  cargo test \
    --release \
    --frozen \
    --all-features \
    --manifest-path dovi_tool/dolby_vision/Cargo.toml
}

package() {
  cd dovi_tool/dolby_vision
  cargo cinstall \
    --release \
    --frozen \
    --prefix /usr \
    --destdir "${pkgdir}"
  install -Dm 644 LICENSE -t "${pkgdir}"/usr/share/licenses/libdovi/
}

# vim: ts=2 sw=2 et:
