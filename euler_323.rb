#!/usr/bin/env ruby

def fact(n)
  (1..n).inject(1, &:*)
end

def choice(n, k)
  fact(n) / fact(k) / fact(n-k)
end

def random_process(n)
  return 0 if n == 0
  leftover = 0
  n.times{ leftover += 1 if rand > 0.5 }
  1 + random_process(leftover)
end

33.times do |i|
  printf "%2d: %s\n", i, 100_000.times.map{ random_process(i) }.sum / 100_000.0
end

# f(0) = 0
# f(1) = 1 + 1/2 f(1) + 1/2 f(0)
# f(k) = 1 + [0..k].sum{|i| chance(i) * f(i) }
# f(k) = [0..k-1].sum{|i| chance(i) * f(i) } / (1 - 2**k)
f = Hash.new do |ht, n|
  p2n = Rational(1, 2**n)
  sum = 0
  (0...n).each do |k|
    sum += f[k] * choice(n, k)
  end
  ht[n] = (1 + sum * p2n) / (1 - p2n)
end

f[0] = 0
33.times do |i|
  printf "%2d: %s %s\n", i, f[i].round(10).to_f, f[i]
end
