#!/usr/bin/env ruby

require "pp"

def read_network(path="network.txt")
  File.readlines(path).map{|line|
    line.chomp.split(/\t|,/).map{|x| x == "-" ? nil : x.to_i}
  }
end

def p107(matrix)
  unification = (0...matrix.size).to_a
  nodes = []
  matrix.each_with_index{|row, i|
    row.each_with_index{|w, j|
      nodes << [w, i, j] if w and i < j
    }
  }
  nodes.sort!
  pp unification
  pp nodes
  w0, w1 = 0, 0
  nodes.each{|w,i,j|
    i = unification[i] while i != unification[i]
    j = unification[j] while j != unification[j]
    if i == j
      w0 += w
    else
      unification[j] = i
      w1 += w
    end
  }
  pp [w0, w1]
end

p107(read_network)
