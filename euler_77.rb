#!/usr/bin/env ruby1.9

require "mathn"

def x(n, elements)
  return 1 if n == 0
  return 0 if elements.empty?
  without_last = x(n, elements[0..-2])
  with_last = (elements[-1] > n) ? 0 : x(n-elements[-1], elements)
  with_last + without_last
end


def p77(n)
  x(n, Prime.each(n).to_a)
end

p p77(10)
(1..100).each{|i|
  p [i, p77(i)]
}
