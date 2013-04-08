#!/usr/bin/env ruby1.9

def pythagorean_triangles
  (1..(1.0/0.0)).each{|a|
    #puts "Trying #{a}" if a % 10_000 == 0
    (1..a).each{|b|
      a2b2 = a*a + b*b
      c = Math.sqrt(a2b2).to_i
      next unless a2b2 == c*c
      yield(b,a,c)
    }
  }
end

def p75_slow(limit)
  x = Hash.new(0)
  pythagorean_triangles{|a,b,c|
    break if 2*b > limit

    l = a+b+c
    next if l > limit
    x[l] += 1
    #p [a,b,c, a+b+c]
    #  break if c > 1_500_000
  }

  e = 0
  x.to_a.sort.each{|l,combinations|
    e += 1 if combinations == 1
  }
  return e
end

p p75_slow(1000)

# limit = 1_500_000

