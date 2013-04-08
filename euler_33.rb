#!/usr/bin/env ruby1.9

require "mathn"

# Cannot cancel first-first as
# (10a+b) / (10a+c) = b/c
# 10ac+bc = 10ab+cb
# 10ac = 10ab
# b=c v a=0

# Cannot cancel second-second as:
# (10a+c) / (10b+c) = a/b
# 10ab+bc = 10ab+ac
# bc=ac
# b=c v a=0 - and a=0 is excluded by rules

(10..99).each{|a|
  (10..99).each{|b|
    next if a >= b
    a0 = a.to_s[0, 1].to_i
    a1 = a.to_s[1, 1].to_i
    b0 = b.to_s[0, 1].to_i
    b1 = b.to_s[1, 1].to_i
    [[a0, b0, a1, b1], [a0, b1, a1, b0], [a1, b0, a0, b1], [a1, b1, a0, b0]].each{|ad,bd,ax,bx|
      next unless ax == bx && ax != 0 && bx != 0
      next unless ad*b == a*bd
      puts "#{a}/#{b} == #{ad}/#{bd}"
    }
  }
}

# (16/64) * (19/95) * (26/65) * (49/98)
# => 1/100
