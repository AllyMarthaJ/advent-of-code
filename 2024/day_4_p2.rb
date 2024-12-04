#!/usr/bin/env ruby
# typed: true

require 'pp'
# include T::Sig

data = STDIN.read

# Top left, bottom right, top right, bottom left
DIRECTIONS = [[-1, -1], [1, 1], [1, -1], [-1, 1]]

VALID_SOLS = [
    ['M' ,'S', 'M', 'S'],
    ['M' ,'S', 'S', 'M'],
    ['S' ,'M', 'M', 'S'],
    ['S' ,'M', 'S', 'M'],
]

data_grid = data.split("\n").map{|line|line.strip.split('')}

# sig do 
#     params(
#         grid: T::Array[T::Array[String]],
#         point: [Integer, Integer],
#     ).returns(Integer)
# end
def star_cnt(grid, point)
    x, y = point

    return 0 if grid[y][x] != 'A'

    letters = []

    DIRECTIONS.each do |direction|
        dx, dy = direction
        if y + dy < 0 || y + dy >= grid.length
            next 
        end
        row = grid[y + dy]
        if x + dx < 0 || x + dx >= row.length
            next
        end
        letters << row[x + dx]
    end

    return VALID_SOLS.include?(letters) ? 1 : 0
end

count = 0
data_grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
        count += star_cnt(data_grid, [x, y])
    end
end
puts "count: #{count.pretty_inspect}"  # XX