#!/usr/bin/env ruby

require 'prospectus'

list = Prospectus.load.select { |x| x.name =~ /^repo::s3::/ }
names = list.map { |x| x.name.split(':').last }
names.each { |x| puts x }

