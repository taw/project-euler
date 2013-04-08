#!/usr/bin/env ruby1.9

require 'mathn'

a = 2
c = 0
999.times{|i|
  b = 1+1/a
  a = 2+1/a
  if b.numerator.to_s.size > b.denominator.to_s.size
    c += 1
    p b
  end
}
p c
