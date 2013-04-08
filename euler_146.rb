#!/usr/bin/env ruby1.9

require "mathn"

def p146_v1(limit)
  e = 0
  i = 0
  Prime.each(limit**2+1).each_cons(6){|ps|
    i+=1
    p ["c#{i}", *ps] if i % 100000 == 0
    next unless ps[1]-ps[0] == 2
    next unless ps[2]-ps[0] == 6
    next unless ps[3]-ps[0] == 8
    next unless ps[4]-ps[0] == 12
    next unless ps[5]-ps[0] == 26
    n2 = ps[0]-1
    n = Math.sqrt(n2).to_i
    if n ** 2 == n2
      e += n
      p ["win", *ps]
    else
      p ["semi-win", *ps]
    end
  }
  e
end

def p146_v2(limit)
  e = 0
  (1..limit).each{|n|
    n2 = n**2
    next unless [1,3,7,9,13,27].all?{|i| (n2+i).prime?}
    next unless [5,11,15,17,19,21,23,25].all?{|i| !(n2+i).prime?}
    p n
    e += n
  }
  e
end

p p146_v2(1_000_000)

# p p146(1_000_000) # 1 242 490

# v1 is too slow to even measure
