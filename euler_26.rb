#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def cyclical?
    prime_division.any?{|p,k| p!=2 && p!=5}
  end
  
  def cycle_length
    return nil unless cyclical?
    a = (1/self)
    seen = []
    while true
      a = (a*10) % 1
      seen << a
      (2...seen.size).each{|i|
        return (i-1) if a == seen[-i]
      }
    end
  end
end

# expected = [[2,nil], [3, 1], [4, nil], [5, nil], [6, 1], [7, 6], [8, nil], [9, 1], [10, nil]]
# actual = (2..10).map{|i| [i, i.cycle_length]}
# 
# p expected
# p actual

(1...1000).each{|d|
  dcl = d.cycle_length
  p [d, dcl] if dcl and dcl > 950
}