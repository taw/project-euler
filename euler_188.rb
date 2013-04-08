#!/usr/bin/env ruby1.9

# powmod is painfully slow...
$memo = {}
def powmod(a, u, m)
  unless $memo[[a,u,m]]
    ai = 1
    u.times{
      ai = (a * ai) % m
    }
    $memo[[a,u,m]] = ai
  end
  $memo[[a,u,m]]
end

def verify_m2(a, m1, m2)
  raise "M2 is bogus" unless powmod(a, m1, m2) == 1
end

def hypex_mod(a, b, m1, m2)
  puts "HM #{b}"
  if b == 1
    return a % m1
  else
    u = hypex_mod(a, b-1, m1, m2) % m2
    rv = powmod(a, u, m1)
    puts "HM #{b} = #{rv}"
    return rv
  end
end

a = 1777
b = 1855
m1 = 100_000_000
m2 = 1_250_000

#verify_m2(a, m1, m2)
p hypex_mod(a, b, m1, m2)

#p powmod(a, 95962097, m1)
