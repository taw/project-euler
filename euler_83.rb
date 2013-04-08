#!/usr/bin/env ruby1.9

require "pp"

def improve!(solution, matrix)
  improved = false
  (0...matrix.size).each{|i|
    (0...matrix[0].size).each{|j|
      neighbours = [solution[i][j-1], solution[i][j+1]].compact
      neighbours << solution[i-1][j] if i != 0
      neighbours << solution[i+1][j] if i != solution.size-1
      new_val = neighbours.min + matrix[i][j]
      if new_val < solution[i][j]
        improved = true
        solution[i][j] = new_val
      end
    }
  }
  return improved
end

def p83(matrix)
  solution = matrix.map{|row| row.map{|cell| (1.0/0.0)}}
  solution[0][0] = matrix[0][0]
  1 while improve!(solution, matrix)
  pp solution
  solution[-1][-1]
end

matrix = File.readlines('matrix.txt').map{|x| x.chomp.split(/,/).map(&:to_i)}

simple_matrix = [
  [131,	673,	234,103,18 ],
  [201,	96 , 342 ,965,150],
  [630,	803,	746,422,111],
  [537,	699,	497,121,956],
  [805,	732,	524,37 ,331],
]

p p83(simple_matrix) # => 2297
p p83(matrix)
