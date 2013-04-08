#!/usr/bin/env ruby1.9

require "mathn"

def p123_v1
  n = 0
  Prime.each{|pn|
    n += 1
    v = ((pn+1) ** n + (pn-1) ** n) % (pn**2)
    yield(n, pn, v)
  }
end

def p123_v2
  n = 0
  Prime.each{|pn|
    n += 1
    v = (-1)**n + 1 + n * pn * (1 + (-1)**(n-1))
    v %= pn**2
    yield(n, pn, v)
  }
end

p123_v2{|n, pn, v|
  if v > 10**10
    p [n, pn, v]
    break
  end
  break if n == 100_000
}

# v1 - 4k: 18.8s
# v2 - 100k: 1.9s
