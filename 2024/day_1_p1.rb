#!/usr/bin/env ruby

data = STDIN.read

def parse_lists(input)
    unpivoted = input.split("\n").map { |line| line.strip.split(/\s+/).map(&:to_i) }.filter{|r| r&&!r.empty?}

    [unpivoted.map(&:first), unpivoted.map(&:last)]
end

def sum_dist_lists(list_1, list_2)
    sorted_list_1 = list_1.sort
    sorted_list_2 = list_2.sort

    sorted_list_1.zip(sorted_list_2).map { |a, b| (b - a).abs }.sum
end

puts "Answer: " + sum_dist_lists(*parse_lists(data)).to_s