#!/usr/bin/env ruby
# typed: true

require 'pp'



data = STDIN.read

res = data.scan(/mul\((\d+),(\d+)\)/).to_a.map{|a,b|a.to_i*b.to_i}.sum

puts "res: #{res.pretty_inspect}"  # XX