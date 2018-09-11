#!/usr/bin/env ruby

puts 'a'

require 'prospectus'

puts 'b'

list = Prospectus.load.select { |x| x.name =~ /^repo::s3::/ }

puts 'c'

names = list.map { |x| x.name.split(':').last }

puts 'd'

names.each { |x| puts x }

puts 'e'
