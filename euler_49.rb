#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def digit_multiset
    to_s.split(//).sort
  end
end


(1000..9999).each{|p0|
  next unless p0.prime?
  p0d = p0.digit_multiset
  (1..9999).each{|i|
    p1, p2 = p0+i, p0+2*i
    break if p2 > 9999
    next unless p1.prime?
    next unless p2.prime?
    next unless p0d == p1.digit_multiset
    next unless p0d == p2.digit_multiset
    p [p0, p1, p2]
  }
}
