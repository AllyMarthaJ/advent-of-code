#!/usr/bin/env ruby

data = STDIN.read

levels = data.split("\n").map{|line| line.strip.split(/\s+/).map(&:to_i)}.filter{|r| r&&!r.empty?}

def array_to_diffs(arr, level = 0)
    [arr.each_cons(2).map{|a,b|b-a}, level == 0 && arrays_without_one(arr).map{|a|array_to_diffs(a, level + 1).first}]
end

def arrays_without_one(arr)
    arr.length.times.map do |i|
        arr.dup.tap{|na|na.delete_at(i)}
    end
end

def diffs_safe(arr, sub_arrs, level = 0)
    arr.all?{|x|x>=1&&x<=3} || arr.all?{|x|x<=-1&&x>=-3} || (level < 1 && sub_arrs.any?{|sa|diffs_safe(sa, sub_arrs, level + 1)})
end
puts "count of safe " + levels.map{|l|array_to_diffs(l)}.filter{|l, s|diffs_safe(l, s)}.length.to_s