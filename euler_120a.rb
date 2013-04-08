#!/usr/bin/env ruby1.9

# (a−1)**(n) + (a+1)**(n)  %  a**2
# Init: (0a + 1)  (0a + 1)
# Step: (Xa + Y)  (Za + V) -> ((Y-X)a - Y) ((V+Z)a + V)
#   or: (Xa + Y)  (Za + 1) -> ((Y-X)a - Y) ((1+Z)a + 1)
#2Step: (Xa + Y)  (Za + 1) -> ((Y-X)a - Y) ((1+Z)a + 1) -> ((X-2Y)a + Y) ((Z+2)a + 1)
#   or: (Xa + 1)  (Za + 1) -> ((1-X)a - 1) ((1+Z)a + 1) -> ((X-2)a + 1) ((Z+2)a + 1)
# N=2K    ((-2K)a + 1)  ((2K)a + 1)  = (-Na + 1)  (Na + 1)  ~~> 2
# N=2K+1  (Na - 1)  (Na + 1) ~~> 2Na

class Array
  def sum
    inject(0, &:+)
  end
end

def fast_120(a,aa,n)
  if n.even?
    2
  else
    (2*n*a) % aa
  end
end

def max_120(a)
  aa = a*a
  (1..2*a).map{|i| fast_120(a, aa, i)}.max
end

p (3..1000).map{|a| max_120(a)}.sum
