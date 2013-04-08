#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def prime?
    pd = prime_division
    (pd.size==1 && pd[0][1] == 1)
  end
  
  def digits
    n = 0
    n += 1 while self >= 10**n
    n
  end
  
  def rotations
    n = digits
    (0...n).map{|i|
      (self % 10**i) * 10**(n-i) + self.div(10**i)
    }.uniq
  end
end

ac = 0
(1..1_000_000).each{|i|
  r = i.rotations
  next unless r.all?(&:prime?)
  ac += 1
  p r
}
p ac
