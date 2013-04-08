#!/usr/bin/env ruby1.9

require "mathn"

def proper_fractions_between(lower, upper, d)
  c = 0
  (1..d).each{|den|
    (1..den).each{|num|
      f = num/den
      break if f >= upper
      next unless f.numerator == num and f > lower
      p f
      c += 1
    }
  }
  c
end

p proper_fractions_between(1/3, 1/2, 8)
p proper_fractions_between(1/3, 1/2, 12_000)
