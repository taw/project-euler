#!/usr/bin/env ruby1.9

# The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.

# For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for
# all the irrational square roots.

def isqrt(n, x)
  until x**2 <= n and (x+1)**2 > n
    x = (x + n/x)/2
  end
  x
end

def fixdec_isqrt(n, d)
  isqrt(n * (10 ** (2*d)), (Math.sqrt(n) * (10**d)).to_i)
end

def sx100(n)
  d = 100
  r = fixdec_isqrt(n, d)
  if r**2 == n*(10**(2*d))
    # p "Square! #{n}"
    return 0 
  else
    #p r
    return r.to_s[0,100].split(//).map(&:to_i).inject(&:+)
  end
end

e=0
(1..100).each{|i|
  e+=sx100(i)
}
p e
