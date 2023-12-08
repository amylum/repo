# Maintainer: Felix Yan <felixonmars@archlinux.org>

pkgname=python-cryptography
pkgver=41.0.7
_commit=4054596afc6f2b6cfcc54f56c35c34e0e429cb66
pkgrel=1
pkgdesc="A package designed to expose cryptographic recipes and primitives to Python developers"
arch=('x86_64')
license=('Apache')
url="https://pypi.python.org/pypi/cryptography"
depends=('python-cffi')
makedepends=('git' 'python-setuptools-rust' 'llvm' 'clang' 'lld')
checkdepends=('python-pytest' 'python-pytest-subtests' 'python-iso8601' 'python-pretend'
              'python-hypothesis' 'python-pytz' 'python-pytest-benchmark')
source=("git+https://github.com/pyca/cryptography.git#commit=$_commit")
sha512sums=('SKIP')

build() {
  cd cryptography
  echo $RUSTFLAGS
  # https://github.com/pyca/cryptography/issues/9023
  CC=clang RUSTFLAGS+="-Clinker-plugin-lto -Clinker=clang -Clink-arg=-fuse-ld=lld" python setup.py build
}

check() {
  cd cryptography
  PYTHONPATH="$PWD/build/lib.linux-$CARCH-cpython-311:$PWD/vectors" pytest
}

package() {
  cd cryptography
  python setup.py install --root="$pkgdir" --optimize=1 --skip-build
}
