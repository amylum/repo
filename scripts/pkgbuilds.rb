module Pkgbuilds
  class Pkgbuild
    def initialize(path)
      @path = path
    end

    def name
      @name ||= File.dirname @path
    end

    def arch_version
      @arch_version ||= line(/^pkgver=/).chomp.split('=').last
    end

    def version
      @version ||= arch_version.tr('_', '-')
    end

    def revision
      @revision ||= line(/^pkgrel=/).chomp.split('=').last
    end

    def arch_full_version
      @arch_full_version ||= "#{arch_version}-#{revision}"
    end

    def package_file
      "#{name}-#{arch_full_version}-x86_64.pkg.tar.xz"
    end

    def url
      @url ||= line(/^url=/).split('"')[1]
    end

    def repo
      @repo ||= url.split('.com/').last
    end

    def dummy?
      @dummy ||= line(/^_dummy=true/)
    end

    def lines
      @lines ||= File.readlines @path
    end

    def line(regex)
      lines.grep(regex).first
    end
  end

  class << self
    def all
      Dir.glob('*/PKGBUILD').map { |x| Pkgbuild.new(x) }
    end
  end
end
