#!/usr/bin/env ruby1.9

def pentagonal(n)
  n*(3*n-1)/2
end

def pent_diff(n, a)
  3*n*a + (3*a*a - a)/2
end

# p pentagonal(40) - pentagonal(33)
# p pent_diff(33, 7)

is_pt = {}
pt = (1..50_000).map{|n| pentagonal(n)}
pt.each_with_index{|x,i| is_pt[x] = i+1}

# Find the pair of pentagonal numbers, P_(j) and P_(k), for which their sum and difference is pentagonal
# and D = |P_(k) − P_(j)| is minimised; what is the value of D?
# 
# b < c in set, such that a=c-b, d=c+b are in set, or equivalently...
# a, b in set, such that c=a+b, d=a+2b are in set

# [1560090, 5482660, 7042750, 8602840].each{|u|
#   p is_pt[u]
#   
# }
# p [1020, 1912, 2167, 2395].map{|n| pentagonal(n)}
# p pentagonal(2167) - pentagonal(1912) - pentagonal(1020)
# p pentagonal(2167) + pentagonal(1912) - pentagonal(2395)

pt.each_with_index{|a,i|
  #p [a, i]
  #break if a > 1560090
  pt.each{|b|
    next unless b > a
    c = a+b
    d = b+c
    next unless is_pt[c]
    p [a, b, c, d]
    next unless is_pt[d]
    exit
  }
}

# raise 'FAIL 1560090 is apparently not it'

__END__

[1560090, 5482660, 7042750, 8602840].each{|u|
  p is_pt[u]
  
}

(1..1000_000).each{|n|
  (1..1000_000).each{|a|
    d = pent_diff(n, a)
    #p [n, n+a, d, is_pt[d]]
    #break if d > 1560090
    next unless is_pt[d]
    p1, p2 = pentagonal(n), pentagonal(n+a)
    e = p1 + p2
    next unless is_pt[e]
    p [is_pt[d], n, n+a, is_pt[e], "--", d, p1, p2, e]
  }
  #break
}
