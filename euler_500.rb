#!/usr/bin/env ruby

require "prime"

def divisors_v1(n)
  (1..n).count{|k| n % k == 0}
end

def divisors_v2(n)
  n.prime_division.map{|p,k| (k+1)}.inject(1, &:*)
end

# 1.26s
# p divisors_v1(120)
# p divisors_v1(10_000_000)

# 0.48s
# p divisors_v2(120)
# p divisors_v2(10_000_000)

def p500_v1(k)
  n = 1
  two_k = 2 ** k
  loop do
    if divisors_v2(n) == two_k
      return n
    else
      n += 1
    end
  end
end

def p500_v2(n)
  mod = 500500507
  solutions = []
  primes = Prime.take(n)
  division = []
  n.times do
    best = [primes.first, nil]
    division.each do |p, k|
      u = p ** (k+1)
      best = [u, p] if u < best[0]
    end
    if best[1] == nil
      division << [primes.shift, 1]
    else
      pk = division.find{|p, k| p == best[1]}
      pk[1] = 2*pk[1] + 1
    end
    solutions << Prime.int_from_prime_division(division) % mod
  end
  solutions
end

def p500_v3(n)
  mod = 500500507
  previous = 1
  solutions = []
  primes = Prime.take(n)
  division = {}
  n.times do
    best = [primes.first, nil]
    division.each do |p, k|
      u = p ** (k+1)
      best = [u, p] if u < best[0]
    end
    if best[1] == nil
      division[primes.shift] = 1
    else
      p = best[1]
      k = division[p]
      division[p] = 2*k + 1
    end
    previous = (previous * best[0]) % mod
    solutions << previous
  end
  solutions
end

def p500_v4(n)
  mod = 500500507
  previous = 1
  solutions = []
  primes = Prime.take(n)
  division = {}
  n.times do
    best = [primes.first, nil]
    division.each do |k, ps|
      p = ps.first or next
      u = p ** (k+1)
      best = [u, k] if u < best[0]
    end
    if best[1] == nil
      p = primes.shift
      division[1] ||= []
      division[1] << p
    else
      k = best[1]
      p = division[k].shift
      k2 = 2*k + 1
      division[k2] ||= []
      division[k2] << p
    end
    previous = (previous * best[0]) % mod
    solutions << previous
    # puts [solutions.size, solutions.last]
  end
  solutions
end

# 22.14s
# p (1..8).map{|k| p500_v1(k) }
# 0.47s
# p p500_v2(8)

# 2.64s
# p p500_v2(2_000)
# 0.72s
# p p500_v3(2_000)

# 6.76s
# p p500_v3(10_000)
# 0.63s
# p p500_v4(10_000)

p p500_v4(500500).last
