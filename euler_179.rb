#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def divisors
    prime_division.map{|p,k| (k+1)}.inject(1, &:*)
  end
end

c = 0
a, b = nil, 2
(2...10**7).each{|i|
  puts i if i % 100_000 == 0
  a, b = b, (i+1).divisors
  c += 1 if a == b
}
p c

# 11m still not done for 10**7

# 10**6 -> 102093 / 1m46s
