#!/usr/bin/env ruby1.9

require "pp"

def all_shapes
  shapes = [
    "((A X B) Y C) Z D",
    "(A X (B Y C)) Z D",
    "(A X B) Y (C Z D)",
    "A X ((B Y C) Z D)",
    "A X (B Y (C Z D))",
  ]
  ops = ['+', '-', '*', '/']
  vars = ['a', 'b', 'c', 'd']
  shapes = shapes.map{|s| ops.map{|op| s.sub('X', op)}}.flatten
  shapes = shapes.map{|s| ops.map{|op| s.sub('Y', op)}}.flatten
  shapes = shapes.map{|s| ops.map{|op| s.sub('Z', op)}}.flatten
  shapes = shapes.map{|s| vars.map{|v| s.sub('A', v)}}.flatten
  shapes = shapes.map{|s| vars.map{|v| s.sub('B', v)}}.flatten
  shapes = shapes.map{|s| vars.map{|v| s.sub('C', v)}}.flatten
  shapes = shapes.map{|s| vars.map{|v| s.sub('D', v)}}.flatten
  shapes = shapes.grep(/a/).grep(/b/).grep(/c/).grep(/d/)
  shapes
end

def obtainable_func
  'lambda{|a,b,c,d| [' + all_shapes.map{|s| "(#{s})"}.join(", ") + ']}'
end

$f = eval(obtainable_func)

def solution_for(*set)
  obtainable = $f[*set.map(&:to_f)].uniq.select{|x| x.finite? && x.to_i == x && x >= 1}.map{|x| x.to_i}.sort
  #pp obtainable
  best = 0
  obtainable.each_with_index{|o,i|
    if o == i+1
      best = o
    else
      break
    end
  }
  best
end

(0..9).each{|a|
  (a+1..9).each{|b|
    (b+1..9).each{|c|
      (c+1..9).each{|d|
        rv = solution_for(a, b, c, d)
        p [rv, a, b, c, d] if rv > 40
      }
    }
  }
}
 
