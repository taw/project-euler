#!/usr/bin/env ruby1.9

ht = Hash.new(0)

(1..1000).each{|a|
  (1..1000).each{|b|
    next if b < a # Already counted as (b, a, c)
    cf = Math.sqrt(a*a + b*b)
    c = cf.to_i
    next unless cf == c
    per = a+b+c
    next if per > 1000
    ht[per] += 1
  }
}

p ht[120]
p ht.to_a.map{|k,v| [v, k]}.sort
