#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def phi
    all = self
    prime_division.each{|p,k|
     all -= (all/p) # painful, but seems to work
    }
    all
  end
end

$chain = Hash.new{|ht,k| ht[k] = 1+$chain[k.phi]}
$chain[1] = 1

# 40_000_000
e = 0
Prime.each(40_000_000){|q|
  $chain[q] = 1 + $chain[q-1] # Make it faster since we know it's a prime so we don't have to factorize
  if $chain[q] == 25
    p q
    e += q
  end
}
p e

# keep full chains:
# 400k -> 17s

# keep counts only:
# 400k -> 11s
# 1M   -> 43s
# eta 40M - 30m

# prime first step optimization:
# 1M -> 13s
# 2M -> 31s
# 4M -> 1m14s
# 40M -> 35m ( 1677366278943 )
