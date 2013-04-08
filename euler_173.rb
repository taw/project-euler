#!/usr/bin/env ruby1.9

def p173(n)
  c = 0
  (1..n).each{|i|
    (i-1).downto(1){|j|
      next unless i.even? == j.even?
      break if i**2 - j**2 > n
      #p [i,j, i**2 - j**2]
      c += 1
    }
  }
  c
end

# p p173(32) # 2 - this
# p p173(100) # 41

p p173(1000_000)
