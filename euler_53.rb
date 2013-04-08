#!/usr/bin/env ruby1.9

r = [1]
ac = 0
(2..101).each{|i|
  r = (r + [0]).zip([0] + r).map{|a,b| a+b}
  p r
  ac += r.select{|x| x > 1_000_000}.size
}
p ac
