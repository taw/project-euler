#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def sum_div
    prime_division.map{|(p,m)| 
      (0..m).map{|i| p**i}.inject(0, &:+)
    }.inject(1, &:*) - self
  end
end

ami = []
(2..10_000).each{|i|
  if i == i.sum_div.sum_div and i != i.sum_div
    p [i, i.sum_div]
    ami << i
    ami << i.sum_div
  end
}
p ami.uniq.inject(&:+)

