#!/usr/bin/env ruby1.9

require "mathn"

def p87(limit)
  seen={}
  Prime.each{|p|
    p4 = p**4
    break if p4 > limit
    Prime.each{|q|
      p4q3 = p4 + q**3
      break if p4q3 > limit
      Prime.each{|r|
        p4q3r2 = p4q3 + r**2
        break if p4q3r2 > limit
        seen[p4q3r2] = true
        #puts [p,q,r,p4q3r2].inspect
      }
    }
  }
  seen.size
end

p p87(50)
p p87(50_000_000)
