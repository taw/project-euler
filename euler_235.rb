#!/usr/bin/env ruby1.9

def s(r, n=5000)
  (1..n).map{|k| (900-3*k) * r**(k-1)}.inject(0, &:+)
end

def find_s(target, a, b)
  sa = s(a)
  sb = s(b)
  while true
    c = (a+b)/2
    sc = s(c)
    if sc > target
      a, sa = c, sc
    else
      b, sb = c, sc
    end
    p [a, sa, target, sb, b, sa > target, target > sb]
  end
end

find_s(-600_000_000_000, 1.00, 1.01)

# wow, 1.002322108633 was correct, no extra precision was necessary
