#!/usr/bin/env ruby1.9

require "mathn"

def gh_v1(set, limit)
  rv = []
  (1..limit).each{|i|
    rv << i if (i.prime_division.map{|p,k| p} - set).empty?
  }
  rv
end

def gh_v2(set, limit)
  if set.empty?
    return [1]
  else
    n = set[0]
    rv = []
    gh_v2(set[1..-1], limit).each{|i|
      (0..(1.0/0.0)).each{|j|
        x = i * (n ** j)
        break if x > limit
        rv << x
      }
    }
    rv
  end
end

primes_100 = Prime.each(100).to_a

# p gh_naive([2,3,5], 100)

# naive / 100k -> 5s


p gh_v2(primes_100, 1_000_000_000).size
#p gh_v1(primes_100, 100_000).size
