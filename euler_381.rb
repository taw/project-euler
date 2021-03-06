#!/usr/bin/env ruby

require "prime"

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end

def s(p)
  # Always cancel
  # e1 = p-1
  # e2 = 1
  e3 = invmod(p-2, p)
  e4 = invmod((p-2)*(p-3) % p, p)
  e5 = invmod((p-2)*(p-3)*(p-4) % p, p)
  (e3+e4+e5) % p
end

def es(maxp)
  e = 0
  Prime.each do |prime|
    next if prime < 5
    break if prime > maxp
    e += s(prime)
  end
  e
end

p s(7)
p es(100)
p es(100_000_000)
