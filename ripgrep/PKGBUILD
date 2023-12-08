# Maintainer: Sven-Hendrik Haase <svenstaro@archlinux.org>
# Maintainer: Maxim Baz <archlinux at maximbaz dot com>
# Contributor: Andrew Gallant <jamslam@gmail.com>
pkgname=ripgrep
pkgver=14.0.3
pkgrel=1
pkgdesc="A search tool that combines the usability of ag with the raw speed of grep"
arch=('x86_64')
url="https://github.com/BurntSushi/ripgrep"
license=('MIT' 'custom')
depends=('gcc-libs' 'pcre2')
makedepends=('rust')
source=("$pkgname-$pkgver.tar.gz::https://github.com/BurntSushi/$pkgname/archive/$pkgver.tar.gz")
sha512sums=('ffe0a7fa619c94cb48642854f0660cc091a09e38d3b9a59baac76f54f0ba2d59a693849fc73b34a09e2fff26f3059dfe396b34a6864b9332bbd3daffe490d4b0')

build() {
  cd "$pkgname-$pkgver"

  cargo build --release --locked --features 'pcre2'
}

check() {
  cd "$pkgname-$pkgver"

  cargo test --release --locked --features 'pcre2'
}

package() {
  cd "$pkgname-$pkgver"

  install -Dm755 "target/release/rg" "$pkgdir/usr/bin/rg"

  mkdir -p "$pkgdir/usr/share/zsh/site-functions"
  target/release/rg --generate complete-zsh > "$pkgdir/usr/share/zsh/site-functions/_rg"

  mkdir -p "$pkgdir/usr/share/bash-completion/completions"
  target/release/rg --generate complete-bash > "$pkgdir/usr/share/bash-completion/completions/rg"

  mkdir -p "$pkgdir/usr/share/fish/vendor_completions.d"
  target/release/rg --generate complete-fish > "$pkgdir/usr/share/fish/vendor_completions.d/rg.fish"

  mkdir -p "$pkgdir/usr/share/man/man1"
  target/release/rg --generate man >  "$pkgdir/usr/share/man/man1/rg.1"

  install -Dm644 "README.md" "$pkgdir/usr/share/doc/${pkgname}/README.md"
  install -Dm644 "COPYING" "$pkgdir/usr/share/licenses/${pkgname}/COPYING"
  install -Dm644 "LICENSE-MIT" "$pkgdir/usr/share/licenses/${pkgname}/LICENSE-MIT"
  install -Dm644 "UNLICENSE" "$pkgdir/usr/share/licenses/${pkgname}/UNLICENSE"
}
