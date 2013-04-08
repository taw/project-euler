#!/usr/bin/env ruby1.9

require "mathn"

def diagonal_layers(k)
  (1..k).each{|i|
    inside_side = 2*i-1
    inside = inside_side**2
    rv = []
    rv << inside + 1*inside_side + 1
    rv << inside + 2*inside_side + 2
    rv << inside + 3*inside_side + 3
    rv << inside + 4*inside_side + 4
    yield(rv, i)
  }
end

# p [1, 3, 5, 7, 9, 13, 17, 21, 25, 31, 37, 43, 49]

primes = 0
total  = 1

diagonal_layers(20_000){|layer, k|
  total += 4
  primes += layer.count{|i| i.prime?}
  if primes/total < 1/10
    p [k, (primes/total).to_f]
    p layer
    break
  end
}
