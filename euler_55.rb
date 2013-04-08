#!/usr/bin/env ruby1.9

class String
  def palindrome?
    self == reverse
  end
end

class Integer
  def reverse
    to_s.split(//).reverse.join.to_i
  end
  
  def rev_add
    self + reverse
  end
  
  def palindrome?
    to_s.palindrome?
  end
  
  def lychrel?
    x = self
    xs = [x]
    50.times{
      x = x.rev_add
      xs << x
      if x.palindrome?
        p ["NO", *xs]
        return false
      end
    }
    p ["YES", *xs]
    return true
  end
end

c = 0
(1..10_000).each{|i|
  c += 1 if i.lychrel?
}
p c
