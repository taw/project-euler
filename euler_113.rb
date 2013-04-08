#!/usr/bin/env ruby1.9

require "pp"

# To avoid double-counting
def constant(digits, n)
  (digits+1) * n
end

# ascending == descending
$memo = {}
def descending(digits, n)
  $memo[[digits, n]] ||= digits.zero? ? 1 : (0..n).map{|m| descending(digits-1, m)}.inject(0, &:+)
end

# Numbers up to n digits
def non_bouncy_upto(n)
  # -1 = "0" doesn't count?
  (1..n).map{|k| descending(9, k)}.inject(&:+) + descending(9, n) - constant(9, n) - 1
end

(1..10).each{|i|
  puts "#{i} -> #{non_bouncy_upto(i)}"
}
#pp $memo

p non_bouncy_upto(6) # == 12951
p non_bouncy_upto(10) # == 277032
p non_bouncy_upto(100)

(1..10).each{|i|
  c=0
  (1...10**i).each{|k|
    c += 1 if k.to_s =~ /\A(?:0*1*2*3*4*5*6*7*8*9*|9*8*7*6*5*4*3*2*1*0*)\Z/
  }
  puts "REAL #{i} -> #{c}"
}
