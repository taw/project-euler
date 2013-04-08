#!/usr/bin/env ruby1.9

require "mathn"

def p71(dmax)
  p (1..dmax).map{|d|
    n=(3*d).div(7)
    a=n/d
    a = (n-1)/d if a == 3/7
    next unless a.numerator == n
    a
  }.compact.max
end

p71(8) # Supposed to be 2/5
p71(1_000_000)
