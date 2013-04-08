#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def p110_v1
    c = 0
    (1..self).each{|a|
      y = self * (self+a) / a
      if y.integer?
        # p [self, a, self*self/a, y, 1/(self+a) + 1/y]
        c += 1
      end
    }
    c
  end


  def p110_v2
    pd = (self**2).prime_division
    dz = [1]
    pd.each{|p,k|
      dz = (0..k).map{|i| dz.map{|d| 
        (p**i) * d
      }}.flatten.select{|x| x<=self}
    }
    dz.count{|a| (self * (self+a) / a).integer?}
  end

  def p110_v3
    pd = (self**2).prime_division
    dz = [1]
    pd.each{|p,k|
      dz = (0..k).map{|i| dz.map{|d| 
        (p**i) * d
      }}.flatten.select{|x| x<=self}
    }
    dz.size
  end

  def p110_v4
    dz = [1]
    prime_division.each{|p,k|
      dz = (0..2*k).map{|i| 
        pi = p**i
        dz.map{|d| pi*d}.select{|x| x<=self}
      }.flatten
    }
    dz.size
  end

  def p110_v5
    i = 1
    prime_division.each{|p,k|
      i *= 2*k+1
    }
    (i+1)/2
  end
end

# (1..1_000).each{|n|
#   u = n.p110_v4
#   v = n.p110_v5
#   p [n, u, v]
# }

(1..1_000_000).each{|n|
  u = n.p110_v5
  p [n, u] if  u > 1000
}

# v1 / 10k -> 35s
# v2 / 10k -> 7s
# v3 / 10k -> 7s
# v4 / 10k -> 1s
# v4 / 100k -> 13.7s
# v5 / 100k -> 4.5s
# v5 / 1M -> 1m41.7s
