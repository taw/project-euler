#!/usr/bin/env ruby1.9
# 
# The sequence 1, 1, 1, 3, 5, 9, 17, 31, 57, 105, 193, 355, 653, 1201 ...
# eig is [ 1 1 1; 1 0 0; 0 1 0 ]

require "mathn"

def trib(n)
  ts = [1,1,1]
  (n-1).times{ ts << ts[-3] + ts[-2] + ts[-1] }
  ts
end

def trib_divides(x)
  ts = [1,1,1]
  seen = {}
  loop{
    key = ts[-3..-1]
    return false if seen[key]
    seen[key] = true
    nx = (ts[-3] + ts[-2] + ts[-1]) % x
    return true if nx == 0
    ts << nx
  }
end

good = []
(1..10_000).each{|d|
  next unless d.odd?
  next if trib_divides(d)
  good << d
  p [good.size, d]
  break if good.size > 125
}
