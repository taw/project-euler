#!/usr/bin/env ruby

# inside_diameter >= 1
# outside_diameter > insider_diameter
# inside_diameter % 2 == outside_diameter % 2

def squares_used(outside_diameter, inside_diameter)
  (outside_diameter**2 - inside_diameter**2)
end

def euler_174(max_n)
  l_ary = (0..max_n).map{ 0 }
  max_d = max_n # actually 1/4 or so, but meh
  (3..max_d).each{|a|
    (a-2).step(1, -2){|b|
      su = squares_used(a,b)
      break if su > max_n
      l_ary[su] += 1
      # p [a, b, su]
    }
  }
  n_ary = []
  l_ary.each{|i|
    n_ary[i] ||= 0
    n_ary[i] += 1
  }
  p n_ary
  p n_ary[1..10].inject(&:+)
end

euler_174(1_000_000)

p squares_used(6, 2)
p squares_used(9, 7)

# => 209566
