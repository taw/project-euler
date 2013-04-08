#!/usr/bin/env ruby1.9

require "pp"

matrix = File.readlines('matrix.txt').map{|x| x.chomp.split(/,/).map(&:to_i)}


simple_matrix = [
  [131,	673,	234,103,18 ],
  [201,	96 , 342 ,965,150],
  [630,	803,	746,422,111],
  [537,	699,	497,121,956],
  [805,	732,	524,37 ,331],
]

def find_minimum_sum(matrix, y, x, memo)
  unless memo[[x,y]]
    this = matrix[y][x]
    rv = if x == 0 and y == 0
      this
    elsif y == 0
      this + find_minimum_sum(matrix, y, x-1, memo)
    elsif x == 0
      this + find_minimum_sum(matrix, y-1, x, memo)
    else
      [
        this + find_minimum_sum(matrix, y, x-1, memo),
        this + find_minimum_sum(matrix, y-1, x, memo),
      ].min
    end
    memo[[x,y]] = rv
  end
  memo[[x,y]]
end

def minimum_sum(matrix)
  y = matrix.size
  x = matrix[0].size
  find_minimum_sum(matrix, y-1, x-1, {})
end

p minimum_sum(simple_matrix)
p minimum_sum(matrix)
