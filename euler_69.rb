#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def phi
    all = self
    prime_division.each{|p,k|
     all -= (all/p) # painful, but seems to work
    }
    all
  end
  
  def phi_slow
    self_pd = prime_division.map{|p,k| p}
    c = 0
    (1...self).each{|i|
      i_pd = i.prime_division.map{|p,k| p}
      c += 1 if self_pd & i_pd == []
    }
    c
  end
end

# p (2..10).map{|i| i.phi}
# p [1,2,2,4,2,6,4,6,4]
# 
# p 997.phi
# p 997.prime_division

p 510510.phi
p 510510.phi_slow

exit

(1..1_000_000).each{|i|
  phi = i.phi
  u = i.to_f/phi
  next unless u >= 5.5
  p [i, u]
}