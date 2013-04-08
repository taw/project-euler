#!/usr/bin/env ruby1.9

require "mathn"
require "rational"

class Integer
  def phi
    all = self
    prime_division.each{|p,k|
      all -= (all/p) # painful, but seems to work
    }
    all
  end
end

def r(n)
  Rational(n.phi, n-1)
end

n = 2
limit = Rational(15499, 94744)
while true
  rn = r(n)
  p [n, rn, rn.to_f, limit.to_f] if rn.to_f < 0.19
  if rn < limit
    p :win
    break
  end  
  n += 1
end

__END__

>> r(2*3*5*7*11*13*17*19*23*29) < Rational(15499, 94744)
=> true

>> r(8*3*5*7*11*13*17*19*23) < Rational(15499, 94744)
=> true

Upper bound of 6,469,693,230 sucks
                 892,371,480
                 
And this is correct answer, but it would take ~2000 minutes for this script to figure it out.
