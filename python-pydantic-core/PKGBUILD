# Maintainer: David Runge <dvzrv@archlinux.org>

_name=pydantic-core
pkgname=python-pydantic-core
# WARNING: this package is pinned down to the patch-level version in python-pydantic and should only be updated in lock-step with it
pkgver=2.14.5
pkgrel=1
epoch=1
pkgdesc="Core validation logic for pydantic written in rust "
arch=(x86_64)
url="https://github.com/pydantic/pydantic-core"
license=(MIT)
depends=(
  gcc-libs
  glibc
  python
  python-typing-extensions
)
makedepends=(
  python-build
  python-installer
  python-maturin
)
checkdepends=(
  python-dirty-equals
  python-hypothesis
  python-pytest
  python-pytest-benchmark
  python-pytest-examples
  python-pytest-mock
  python-pytest-timeout
)
options=(!lto)
source=($pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz)
sha512sums=('2aceef9709f85e5afd583314be725f9c0ae7eb9cb45f924abca3317f2addd82ed23b7645a37d5d14e2a7f204ce81db6aa4b44a0210fbd0f068e119ddb9e8eafb')
b2sums=('208d757623aa9533a4f7c12909534c23566a48d314e282a37e6d0ac603b438e156bfac36fa197b32ab3573bc47702ddf503bd17b81fd82062f9e4310c7a46d15')

prepare() {
  # we don't support version pinning
  sed -e 's/,!=4.7.0//g' -i $_name-$pkgver/pyproject.toml
}

build() {
  cd $_name-$pkgver
  python -m build --wheel --no-isolation
}

check() {
  local pytest_options=(
    -vv
  )
  local site_packages=$(python -c "import site; print(site.getsitepackages()[0])")

  cd $_name-$pkgver
  # install to temporary location, as importlib is used
  python -m installer --destdir=test_dir dist/*.whl
  export PYTHONPATH="$PWD/test_dir/$site_packages:$PYTHONPATH"
  HYPOTHESIS_PROFILE=slow pytest "${pytest_options[@]}"
}

package() {
  cd $_name-$pkgver
  python -m installer --destdir="$pkgdir" dist/*.whl
  install -vDm 644 LICENSE -t "$pkgdir/usr/share/licenses/$pkgname/"
  install -vDm 644 README.md -t "$pkgdir/usr/share/doc/$pkgname/"
}
