#!/usr/bin/env ruby
# typed: true

require 'pp'

data = "do()" + STDIN.read

res = data.split(/do\(\)/).map{|r|r.split(/don't\(\)/).first}.compact.flat_map{|r|r.scan(/mul\((\d+),(\d+)\)/).to_a}.map{|a,b|a.to_i*b.to_i}.sum

puts "res: #{res.pretty_inspect}"  # XX