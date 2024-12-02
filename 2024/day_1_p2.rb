#!/usr/bin/env ruby

data = STDIN.read

def parse_lists(input)
    unpivoted = input.split("\n").map { |line| line.strip.split(/\s+/).map(&:to_i) }.filter{|r| r&&!r.empty?}

    [unpivoted.map(&:first), unpivoted.map(&:last)]
end

def calculate_sim_score(list_1, list_2)
    count_by_entry = list_2.group_by(&:itself).transform_values(&:count)
    list_1.map { |entry| count_by_entry.fetch(entry, 0) * entry }.sum
end

puts "Answer: " + calculate_sim_score(*parse_lists(data)).to_s