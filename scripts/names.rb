#!/usr/bin/env ruby

require_relative './pkgbuilds.rb'

filter = ARGV.shift
a = Pkgbuilds.all
a.select! { |x| x.name + '/' + x.package_file == filter } if filter
a.each { |x| puts x.name }
