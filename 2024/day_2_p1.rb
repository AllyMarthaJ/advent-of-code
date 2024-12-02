#!/usr/bin/env ruby

data = STDIN.read

levels = data.split("\n").map{|line| line.strip.split(/\s+/).map(&:to_i)}.filter{|r| r&&!r.empty?}

def array_to_diffs(arr)
    arr.each_cons(2).map{|a,b|b-a}
end

def diffs_safe(arr)
    arr.all?{|x|x>=1&&x<=3} || arr.all?{|x|x<=-1&&x>=-3}
end

puts "count of safe " + levels.map{|l|array_to_diffs(l)}.filter{|l|diffs_safe(l)}.length.to_s