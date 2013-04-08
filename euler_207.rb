#!/usr/bin/env ruby1.9

require "mathn"

def each_alpha_k
  (2..(1.0/0.0)).each{|u|
    next if u.even?
    alpha = (1 + u)/2
    k = (u**2-1)/4.0
    # p [alpha, u, k]
    raise "FAIL" unless alpha**2 - alpha - k == 0
    yield(alpha, k)
  }
end

partitions = 0
perfect_partitions = 0
each_alpha_k{|alpha,k|
  partitions += 1
  if alpha & (alpha-1) == 0 # power of 2 test, correct?
    perfect_partitions += 1
  end
  p [alpha, k, perfect_partitions, partitions]
  break if Rational(perfect_partitions, partitions) < Rational(1, 12345)
}
