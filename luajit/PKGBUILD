# Maintainer: Daurnimator <daurnimator@archlinux.org>
# Maintainer: Lukas Fleischer <lfleischer@archlinux.org>
# Contributor: Bartłomiej Piotrowski <bpiotrowski@archlinux.org>
# Contributor: Chris Brannon <chris@the-brannons.com>
# Contributor: Paulo Matias <matiasΘarchlinux-br·org>
# Contributor: Anders Bergh <anders1@gmail.com>

pkgname=luajit
# LuaJIT has a "rolling release" where you should follow git HEAD
_commit=43d0a19158ceabaa51b0462c1ebc97612b420a2e
# The patch version is the timestamp of the above git commit, obtain via `git show -s --format=%ct`
_ct=1700008891
pkgver="2.1.${_ct}"
pkgrel=1
pkgdesc='Just-in-time compiler and drop-in replacement for Lua 5.1'
arch=('x86_64')
url='https://luajit.org/'
license=('MIT')
depends=('gcc-libs')
source=("LuaJIT-${_commit}.tar.gz::https://repo.or.cz/luajit-2.0.git/snapshot/${_commit}.tar.gz")
md5sums=('e3822c36f8252c0183b0f7928c1c5477')
sha256sums=('2c8e8bdb85eb3327b5c4ba895caea20ac8f243292df90975edf9f0f736f77770')
b2sums=('d8efc671726b881d32cf1d9b4fad425bb1c6af41d75bdb10b34c8da00657551c232e2fa0876ae3899e50134715007bd30790665c8bfd7ca98d1d891adbbbf897')

build() {
  cd "luajit-2.0-${_commit::7}"

  # Avoid early stripping
  make amalg PREFIX=/usr BUILDMODE=dynamic TARGET_STRIP=" @:"
}

check() {
  cd "luajit-2.0-${_commit::7}"

  # Make sure that _ct was updated
  test "${_ct}" == "$(cat .relver)"
}

package() {
  cd "luajit-2.0-${_commit::7}"

  make install DESTDIR="$pkgdir" PREFIX=/usr
  install -Dm644 COPYRIGHT "$pkgdir/usr/share/licenses/$pkgname/COPYRIGHT"
}
