#!/usr/bin/env ruby1.9

c = 0
(1..2000).each{|i|
  (1..(1.0/0.0)).each{|a|
    ai = a**i
    break if ai >= 10**i
    next unless ai >= 10**(i-1)
    c+=1
    p [a, i, ai]
  }
}
p c
