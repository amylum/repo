# Maintainer: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
# Contributor: Pierre Schmitz <pierre@archlinux.de>

pkgbase=ca-certificates
pkgname=(
  ca-certificates-utils
  ca-certificates
)
pkgver=20220905
pkgrel=1
pkgdesc="Common CA certificates"
url="https://src.fedoraproject.org/rpms/ca-certificates"
arch=(any)
license=(GPL)
makedepends=(
  asciidoc
  p11-kit
)
source=(
  40-update-ca-trust.hook
  README.{etc,etcssl,extr,java,src,usr}
  update-ca-trust
  update-ca-trust.8.txt
)
b2sums=('82e3d728267d931dd8613f5e4944995fb1909dffdd61bce17c5c8aa0e8d14201d249cb25899ac631e6a44a6d2acc02e62bd17692fd7fd27e3c8fb9a7648c6004'
        '0de3d4ce83f00f95ea7b94f497403b4dc7ff5d0de33bdc76abe3bdd02280d6dc494c7ca4334cfdc5b91ab3fb0022c69f6809eca67d12e77048aa7f70252d479c'
        'a43766c7e451b3053abee99f8c9c526d984e20c1e60f1ef6e685805bbca46afa2725c7768a16ac5464778132fb13b43e59b2145ea89e4d2058f68cd2bf0abb1a'
        '21a528aa19b378c6cd7fc2a7281f997236b117e37d087c95640a7ee27511ecaf33e282e0a03b75382c20aefbec9fb24b60a2c5282fdaa4cffe074cebd6e3eaf8'
        '9fdd34c3f99a01a0d12bb48595114def7685841f81871f5dbf56c433e19bb3acb733e108e6463b48425cd4b74a41ee961c927b24c2dce65f26a37baae5ed9eb9'
        '1fbefe367f9e59e7bc5886d07b7da8bd918c8b77ab0d2026813dad965294d2bb3fd4698d6b22e728d890044b98c0015e7328c050c5d96d0e7d2a3a1ae3f16362'
        '57e5f6485cde17139e3d1649bd05e1f1b7e260ec58137d41e91ac938bc728bed8ee72eacd0d03f1ccb8cd9e2a23df0df1b2f5fd46694530e1cb49325b05d68fd'
        '7504993b03229da357e4c238baa5426195252a7ffa24f757f266ab5e1e530f1deabb55be6501f0fd9ef99fdbea4dbb189410358e17c7ab77186ab6032f7c16a1'
        '3e684293c9ea704054be631ef531e1aa8a542eaa77559cb2bf3cb47bdab285f2eae3206028911b85248150e4cc4096b098a32663e0ddbe9ed5b11bd2d121a63a')

build() {
  a2x -v -f manpage update-ca-trust.8.txt
}

package_ca-certificates-utils() {
  pkgdesc+=" (utilities)"
  depends=(
    bash
    coreutils
    findutils
    'p11-kit>=0.24.0'
  )
  provides=(
    ca-certificates
    ca-certificates-java
  )
  conflicts=(ca-certificates-java)
  replaces=(ca-certificates-java)
  install=ca-certificates-utils.install

  install -Dt "$pkgdir/usr/bin" update-ca-trust
  install -Dt "$pkgdir/usr/share/man/man8" -m644 update-ca-trust.8
  install -Dt "$pkgdir/usr/share/libalpm/hooks" -m644 *.hook

  # Trust source directories
  install -Dm644 README.etc "$pkgdir/etc/$pkgbase/README"
  install -Dm644 README.src "$pkgdir/etc/$pkgbase/trust-source/README"
  install -Dm644 README.usr "$pkgdir/usr/share/$pkgbase/trust-source/README"
  install -d "$pkgdir"/{etc,usr/share}/$pkgbase/trust-source/{anchors,blocklist}

  # Directories used by update-ca-trust (aka "trust extract-compat")
  install -Dm644 README.etcssl "$pkgdir/etc/ssl/README"
  install -Dm644 README.java   "$pkgdir/etc/ssl/certs/java/README"
  install -Dm644 README.extr   "$pkgdir/etc/$pkgbase/extracted/README"

  # Compatibility link for OpenSSL using /etc/ssl as CAdir
  # Used in preference to the individual links in /etc/ssl/certs
  ln -sr "$pkgdir/etc/$pkgbase/extracted/tls-ca-bundle.pem" "$pkgdir/etc/ssl/cert.pem"

  # Compatibility link for legacy bundle (Debian)
  ln -sr "$pkgdir/etc/$pkgbase/extracted/tls-ca-bundle.pem" "$pkgdir/etc/ssl/certs/ca-certificates.crt"

  # Compatibility link for legacy bundle (RHEL/Fedora)
  ln -sr "$pkgdir/etc/$pkgbase/extracted/tls-ca-bundle.pem" "$pkgdir/etc/ssl/certs/ca-bundle.crt"
}

package_ca-certificates() {
  pkgdesc+=" (default providers)"
  depends=(ca-certificates-mozilla)
  conflicts=('ca-certificates-cacert<=20140824-4')
  replaces=("${conflicts[@]}")
}

# vim:set sw=2 sts=-1 et:
