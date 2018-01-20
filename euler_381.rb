#!/usr/bin/env ruby

require "prime"

class Integer
  def bang
    (1..self).inject(1, &:*)
  end
end

def s(p)
  (1..5).map{|k| (p-k).bang }.sum % p
end

def es(maxp)
  e = 0
  Prime.each do |prime|
    next if prime < 5
    break if prime > maxp
    e += s(prime)
  end
  e
end

p s(7)
p es(100)

p es(2000)
