#!/usr/bin/env ruby1.9

raise 'FAIL'

class Array
  def sum
    inject(0, &:+)
  end
end

def naive_120(a,n)
  ((a-1)**n + (a+1)**n) % a**2
end

def fast_120(a,n)
  if n.even?
    2
  else
    a * (2*n % a)
  end
end

def max_120_seminaive(a)
  (1..a*a).map{|i| fast_120(a, i)}.max
end

def max_120_smart(a)
  rv = 2
  (1..a*a).each{|n|
    next if n.even?
    break if 2*n % a == 0
    rv = [a * (2*n%a), rv].max
  }
  rv
end


p naive_120(7, 3)
p fast_120(7, 3)

p naive_120(7, 4)
p fast_120(7, 4)

p max_120_seminaive(7)
p max_120_smart(7)

p max_120_seminaive(192)
p max_120_smart(192)

p (3..1000).map{|a| max_120_smart(a)}.sum
p (3..1000).map{|a| max_120_seminaive(a)}.sum
