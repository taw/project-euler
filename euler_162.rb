#!/usr/bin/env ruby1.9

def p162_naive(size)
  c = 0
  (0...16**size).each{|i|
    digits = []
    while i > 0
      digits << i%16
      i /= 16
    end
    c += 1 if (digits & [0,1,10]).size == 3
  }
  c
end

$hc = {}
def hc(s0, s1, sa, todo)
  # p ["hc", s0, s1, sa, todo]
  rv = $hc[[s0,s1,sa,todo]] ||= if todo == 0
    (s0&s1&sa) ? 1 : 0
  else
    13 * hc(s0, s1, sa, todo-1) +
         hc(true, s1, sa, todo-1) +
         hc(s0, true, sa, todo-1) +
         hc(s0, s1, true, todo-1)
  end
  # p ["hc", s0, s1, sa, todo, '->', rv]
  rv 
end

def p162_fast(limit)
  (3..limit).map{|i|
         hc(false, true, false, i-1) +
         hc(false, false, true, i-1) +
    13 * hc(false, false, false, i-1)
  }.inject(&:+)
end

p p162_fast(3)
p p162_fast(4)
p p162_fast(5)

p p162_naive(3)
p p162_naive(4)
p p162_naive(5)

rv = p162_fast(16)
p rv
p rv.to_s(16).upcase
