#!/usr/bin/env ruby1.9

require "mathn"

# 2,3 5,6 8,9 cannot exist due to divisibility by 3
Prime.each(10_000_000_000){|p|
  d = p.to_s.split(//)
  ex_d = (1..d.size).map(&:to_s)
  ac_d = d.uniq.sort
  next unless ex_d == ac_d
  p p
}
