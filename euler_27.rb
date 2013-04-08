#!/usr/bin/env ruby1.9

require "pp"
require "mathn"

class Integer
  def prime?
    return false if self < 2
    pd = prime_division
    (pd.size==1 && pd[0][1] == 1)
  end
end

def prime_counts(a,b)
  n = 0
  n += 1 while (n*n + a*n + b).prime?
  return n
end

rv = []

(-1000..1000).each{|a|
  (-1000..1000).each{|b|
    pc = prime_counts(a, b)
    rv << [a, b, pc] if pc >= 40
  }
}

pp rv.sort
