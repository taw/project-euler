#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def sum_div
    prime_division.map{|(p,m)| 
      (0..m).map{|i| p**i}.inject(0, &:+)
    }.inject(1, &:*) - self
  end
  def abundant?
    sum_div > self
  end
end

abundant_numbers = (1..30_000).select(&:abundant?)

can = {}
abundant_numbers.each{|i|
  abundant_numbers.each{|j|
    can[i+j] = true
  }
}
ac = 0
(1..30000).each{|x|
  next if can[x]
  p x
  ac += x
}
p ac

