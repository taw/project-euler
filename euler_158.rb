#!/usr/bin/env ruby1.9

class Integer
  def fact
    (1..self).inject(1, &:*)
  end
end

def p158_v1(limit)
  e = 0
  (0...26**limit).each{|i|
    ds = []
    limit.times{
      ds << i%26
      i /= 26
    }
    e += 1 if ds.uniq.size == limit and (0..limit-2).count{|i|(ds[i+1]-ds[i]) > 0} == 1
  }
  e
end

def choose(n, k)
  n.fact / k.fact / (n-k).fact
end

def p158_v2(limit)
  e = 0
  (0..limit**limit).each{|i|
    ds = []
    limit.times{
      ds << i%limit
      i /= limit
    }
    e += 1 if ds.uniq.size == limit and (0..limit-2).count{|i|(ds[i+1]-ds[i]) > 0} == 1
  }
  choose(26, limit) * e
end

def p158_v3(limit)
  e = 0
  (0..limit-2).each{|a|
    (a+1...limit).each{|b|
      m = b-a-1
      e += 2**m
      #p [a, b, m, 2**m]
    }
  }
  choose(26, limit) * e
end

p (1..26).map{|i| p158_v3(i)}.max

# v2 / 7 -> 4.4s
