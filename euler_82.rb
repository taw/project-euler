#!/usr/bin/env ruby1.9

require "pp"

class Array
  def transpose
    (0...self[0].size).map{|i|
      (0...size).map{|j|
        self[j][i]
      }
    }
  end
end

matrix = File.readlines('matrix.txt').map{|x| x.chomp.split(/,/).map(&:to_i)}.transpose

simple_matrix = [
  [131,	673,	234,103,18 ],
  [201,	96 , 342 ,965,150],
  [630,	803,	746,422,111],
  [537,	699,	497,121,956],
  [805,	732,	524,37 ,331],
].transpose

def p82_step(solution, layer)
  s0 = (0...solution.size).map{|i|
    solution[i] + layer[i]
  }
  (1...solution.size).each{|i|
    s0[i] = [s0[i], layer[i] + s0[i-1]].min
  }
  (solution.size-2).downto(0){|i|
    s0[i] = [s0[i], layer[i] + s0[i+1]].min
  }
  s0
end


def p82(layers)
  solution = layers[0]
  p solution
  (1...layers.size).each{|i|
    solution = p82_step(solution, layers[i])
    p solution
  }
  solution.min
end

pp simple_matrix

pp p82(simple_matrix)

pp p82(matrix)
