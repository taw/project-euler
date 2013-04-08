#!/usr/bin/env ruby1.9

require "mathn"

def p132_v1(n)
  x = 0
  n.times{
    x = x*10 + 1
  }
  x.prime_division.map{|p,k| [p]*k}.flatten
end

def repunit_test(n, m)
  x = 0
  n.times{
    x = (x*10 + 1) % m
  }
  x == 0
end

def p132_v2(n, limit_c, limit_n)
  factors = []
  Prime.each(limit_n){|p|
    (1..(1.0/0)).each{|k|
      unless repunit_test(n, p**k)
        break
      end
      factors << p
      break if factors.size >= limit_c
    }
    break if factors.size >= limit_c
  }
  factors
end

def repunit_test_v2(n, m)
  # We're looking for (111111)_n % m
  # Numbers we're interested in are: Xi = (1111)_(2^i)   %   m
  # They can be composed via: X(i+1) = Xi + (10^2^i) Xi    %  m
  xi = [1]
  x = 0
  dti = 1
  (0..(1.0/0.0)).each{|i|
    ti = 2**i
    if i == 0
      dti = 10 % m
    else
      dti = (dti * dti) % m
    end
    if n & ti != 0
      x = (xi[-1] + x * dti) % m
      n ^= ti
    end
    xi << (xi[-1] + xi[-1] * dti) % m
    break if n == 0
  }
  x == 0
end


def p132_v3(n, limit_c, limit_n)
  factors = []
  Prime.each(limit_n){|p|
    (1..(1.0/0)).each{|k|
      unless repunit_test_v2(n, p**k)
        break
      end
      factors << p
      break if factors.size >= limit_c
    }
    break if factors.size >= limit_c
  }
  factors
end

#p p132_v2(10000, 20, nil)
fs = p132_v3(10**9, 40, nil)
p fs.inject(&:+)

# p repunit_test(10, 11)
# p repunit_test_v2(10, 11)
# 
# p repunit_test(10, 13)
# p repunit_test_v2(10, 13)

# v2: 10k / 20 -> 4.8s
# v3: 10k / 20 -> 9.7s (with slow 10**ti)
# v3: 10k / 20 -> 0.1s (with fast 10**ti)
