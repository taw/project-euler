#!/usr/bin/env ruby1.9

require "mathn"

def repunit_rem_a(n, k)
  ("1" * n).to_i % k
end

def primes(max)
  (2..max).select(&:prime?)
end

def repunit_pow_rem_1(i, k)
  n = 10**i
  x = 0
  n.times{ x = (10*x + 1) % k }
  x
end

def repunit_pow_rem_2(i, k)
  x = 1
  y = 10
  i.times{
    x = x * (y**9 + y**8 + y**7 + y**6 + y**5 + y**4 + y**3 + y**2 + y + 1) % k
    y = (y ** 10) % k
  }
  x
end

def repunit_pow_fixpoint(k)
  seen = {}
  x, y = 1, 10%k
  until seen[[x,y]]
    return true if x == 0
    seen[[x,y]] = true
    y2 = (y*y) % k
    y4 = (y2*y2) % k
    y8 = (y4*y4) % k
    x = x * (y+1) * (y8 + (y4+1)*(y2+1)) % k
    y = (y8 * y2) % k
  end
  return false
end


all = primes(100_000).inject(&:+)

oks = []

primes(100_000).each{|pr|
  ok = repunit_pow_fixpoint(pr)
  oks << pr if ok
}
sum = oks.inject(&:+)

p oks
p sum
p all - sum


__END__
[11, 17, 41, 73, 101, 137, 251, 257, 271, 353, 401, 449, 641, 751, 1201, 1409, 1601, 3541, 4001, 4801, 5051, 9091, 10753, 15361, 16001, 19841, 21001, 21401, 24001, 25601, 27961, 37501, 40961, 43201]
338034

real	0m31.042s
user	0m30.140s
sys	0m0.228s

[11, 17, 41, 73, 101, 137, 251, 257, 271, 353, 401, 449, 641, 751, 1201, 1409, 1601, 3541, 4001, 4801, 5051, 9091, 10753, 15361, 16001, 19841, 21001, 21401, 24001, 25601, 27961, 37501, 40961, 43201, 60101, 62501, 65537, 69857, 76001, 76801]
748832

real	2m15.082s
user	2m11.596s
sys	0m0.876s
