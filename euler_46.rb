#!/usr/bin/env ruby1.9

require "mathn"

primes   = Prime.each(10_000).to_a 
dsquares = (1..100).map{|a| 2*(a**2)}

p primes
p dsquares

seen = {}

primes.each{|p|
  dsquares.each{|d|
    seen[p+d] = true
  }
}

win = []
(1..10_000).each{|i|
#  p i unless seen[i]
  win << i if (not seen[i]) and i.odd? and (not i.prime?)
}
p win
