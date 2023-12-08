# Maintainer: George Rawlinson <grawlinson@archlinux.org>
# Maintainer: Kyle Keen <keenerd@gmail.com>
# Contributor: Michael Düll <mail@akurei.me>

pkgname=rtl-sdr
pkgver=2.0.1
pkgrel=3
epoch=1
pkgdesc='Driver for Realtek RTL2832U, allowing general purpose software defined radio (SDR)'
arch=('x86_64')
url='https://osmocom.org/projects/rtl-sdr/wiki'
license=('GPL')
depends=('glibc' 'libusb')
makedepends=('git' 'cmake')
install=rtl-sdr.install
_commit='420086af84d7eaaf98ff948cd11fea2cae71734a'
source=(
  "$pkgname::git+https://gitea.osmocom.org/sdr/rtl-sdr#commit=$_commit"
  'fix-udev-directory.patch'
  "$pkgname.sysusers"
)
b2sums=('SKIP'
        '2356582926b8bb0b1b7bbf22dd046ae9c55855a925818730d8e9558e4620f8f6599663aec50e0bdb5c1e7f1242e8f170d2f9eecb0808e42f53d06ea6a812ec64'
        'ff6d84a21f23ea3da8771cbf6f6344d7ac7a52a0987b6f8974bc083efee3389250402e861b233460228439fb8c7e35c4f98cf91254ecc5d956742158fd565cc3')

pkgver() {
  cd "$pkgname"

  git describe --tags | sed 's/^v//'
}

prepare() {
  cd "$pkgname"

  # ensure udev rules get installed to correct directory
  patch -p1 -i "$srcdir/fix-udev-directory.patch"

  # fix udev rules and allow access to any user that is locally logged in or in the rtlsdr group
  # https://bugzilla.redhat.com/show_bug.cgi?id=815093
  sed -e 's/GROUP="plugdev"/GROUP="rtlsdr", TAG+="uaccess"/' -i rtl-sdr.rules
}

build() {
  cmake \
    -S "$pkgname" \
    -B build \
    -D CMAKE_INSTALL_PREFIX=/usr \
    -D CMAKE_C_FLAGS="$CFLAGS -ffat-lto-objects" \
    -D DETACH_KERNEL_DRIVER=ON \
    -D INSTALL_UDEV_RULES=ON \
    -W no-dev

  cmake --build build
}

package() {
  DESTDIR="$pkgdir" cmake --install build

  # rtlsdr group creation
  install -vDm644 $pkgname.sysusers "$pkgdir/usr/lib/sysusers.d/$pkgname.conf"

  cd "$pkgname"

  # module blacklisting rules
  install -vDm644 debian/rtl-sdr-blacklist.conf "$pkgdir/usr/lib/modprobe.d/rtlsdr.conf"

  # man pages
  install -vDm644 -t "$pkgdir/usr/share/man/man1" debian/*.1
}

# vim:set ts=2 sw=2 et:
