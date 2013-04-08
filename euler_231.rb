#!/usr/bin/env ruby1.9

require "mathn"

def pef(f, t)
  e = 0
  (f..t).each{|i|
    puts i if i % 10_000 == 0
    i.prime_division.each{|p,k| e += p*k}
  }
  e
end

def p231(n,k)
  k = [k, n-k].min
  pef(n-k+1, n) - pef(1, k)
end

p p231(10, 3) # => 14
#p p231(200000, 150000) # => 1046194048
#p p231(2000000, 1500000)
p p231(20000000, 15000000)

# x5: 23s [factorial version]
# x5: 6s [birange version]
