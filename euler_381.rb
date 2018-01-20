#!/usr/bin/env ruby

require "prime"

class Integer
  def bang
    (1..self).inject(1, &:*)
  end

  def bang_mod(p)
    a = 1
    (2..self).each do |i|
      a = (a*i) % p
    end
    a
  end
end

def s(p)
  a = (p-5).bang_mod(p)
  b = a*(p-4)
  c = b*(p-3)
  d = c*(p-2)
  e = d*(p-1)
  (a+b+c+d+e) % p
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

p es(20000)
