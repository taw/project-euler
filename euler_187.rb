#!/usr/bin/env ruby1.9

require "mathn"

def p187_v1(n)
  c = 0
  (1..n).each{|i|
    c += 1 if i.prime_division.map{|p,k| k}.inject(0, &:+) == 2
  }
  c
end

def p187_v2(n)
  c = 0
  Prime.each(n){|p|
    Prime.each(p){|q|
      break if p*q > n
      c += 1
    }
  }
  c
end

def p187_v3(n)
  c = 0
  ps = []
  Prime.each(n){|p|
    ps << p
    while !ps.empty? and ps[-1] * p > n
      ps.pop
    end
    break if ps.empty?
    c += ps.size
  }
  c
end

# v1: 100k -> 4.7s
# v2: 1M -> 2.3s
# v2: 10M -> 25s
# v3: 10M -> 7s

p p187_v3(10**8)
