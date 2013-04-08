#!/usr/bin/env ruby1.9

class FibString
  attr_accessor :size, :a, :b
  
  def initialize(a, b)
    @a, @b = a, b
    @size = a.size + b.size
  end
  
  def [](i)
    if i >= size
      nil
    elsif i >= a.size
      b[i - a.size]
    else
      a[i]
    end
  end
end

def p230_naive(a, b, n)
  p ['el', a]
  while a.size <= n
    a, b = b, a+b
    p ['el', a]
  end
  a[n]
end

def p230_fast(a, b, n)
  while a.size <= n
    a, b = b, FibString.new(a, b)
  end
  a[n]
end

p p230_naive('1415926535', '8979323846', 35-1)
p p230_fast('1415926535', '8979323846', 35-1)

a = '1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679'
b = '8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196'

e = 0
(0..17).map{|n|
  un = (127+19*n) * (7**n)
  x = 10**n * p230_fast(a, b, un-1).to_i
  e += x
}
p e
