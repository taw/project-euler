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
end

def p72_slow(x)
  c = 0
  (2..x).each{|d|
    (1...d).each{|n|
      next unless (n/d).numerator == n
      c += 1
    }
  }
  c
end

def p72(x)
  c = 0
  (2..x).each{|d|
    p "progress #{d}" if d %1000 == 0
    c+=d.phi
  }
  c
end


p p72_slow(8)
p p72_slow(1_000)

p p72(8)
p p72(1_000)
p p72(1_000_000)