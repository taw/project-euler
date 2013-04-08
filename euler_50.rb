#!/usr/bin/env ruby1.9

require "mathn"

def forever(i, &blk)
  (i..(1.0/0.0)).each(&blk)
end

def e50(top)
  primes = Prime.each(top).to_a
  primes.each_with_index{|p0, i|
    e = p0
    forever(1){|j|
      np = primes[i+j]
      break unless np
      e += np
      break if e > top
      next unless e.prime?
      p [p0, j+1, e] if j+1 >= 543
    }
  }
end

e50(1_000_000)
