#!/usr/bin/env ruby
# typed: true

require 'pp'
# include T::Sig

data = STDIN.read

DIRECTIONS = [[1, 0], [0, 1], [0, -1], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]

data_grid = data.split("\n").map{|line|line.strip.split('')}

# sig do 
#     params(
#         word: String,
#         grid: T::Array[T::Array[String]],
#         point: [Integer, Integer],
#         direction: [Integer, Integer]
#     ).returns(Integer)
# end
def wordsearch_cnt(word, grid, point, direction)
    x, y = point
    dx, dy = direction

    if word.length == 0
        return 1
    end

    if y < 0 || y >= grid.length || x < 0 || x >= grid[y].length || grid[y][x] != word[0]
        return 0
    end

    return wordsearch_cnt(word[1..], grid, [x + dx, y + dy], direction)
end

count = 0
data_grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
        DIRECTIONS.each do |direction|
            count += wordsearch_cnt('XMAS', data_grid, [x, y], direction)
        end
    end
end
puts "count: #{count.pretty_inspect}"  # XX