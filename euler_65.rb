#!/usr/bin/env ruby1.9

require "mathn"

def build_cf(*factors)
  rv = nil
  factors.reverse.each{|x|
    rv = rv.nil? ? x : (x + 1/rv)
  }
  rv
end

def ef
  yield 2
  (1..(1.0/0.0)).each{|i|
    yield 1
    yield i*2
    yield 1
  }
end

def e_approx(ith)
  efv = []
  ef{|x|
    efv << x
    break if efv.size == ith
  }
  build_cf(*efv)
end

def p65(ith)
  e_approx(ith).numerator.to_s.split(//).map(&:to_i).inject(&:+)
end

(1..10).each{|i|
  p e_approx(i)
}

p p65(10)
p p65(100)
