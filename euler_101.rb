#!/usr/bin/env ruby1.9

require "mathn"

def approx(k, x, datapoints)
  (1..k).map{|i|
    (1..k).map{|j|
      if i == j
        datapoints[i-1]
      else
        (x-j) / (i-j)
      end 
    }.inject(1, &:*)
  }.inject(0, &:+)
end

# n3 = (1..10).map{|n| n**3}
# (1..4).each{|i|
#   p (1..10).map{|x| approx(i, x, n3)}
# }

u = (1..50).map{|x| 1 - x + x**2 - x**3 + x**4 - x**5 + x**6 - x**7 + x**8 - x**9 + x**10}
p u

e = 0
(1..15).each{|i|
  az = (1..50).map{|x| approx(i, x, u)}
  (0..49).each{|j|
    if az[j] != u[j]
      p [i, j, az[j], u[j]]
      e += az[j]
      break
    end
  }
}

p e
