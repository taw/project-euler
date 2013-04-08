#!/usr/bin/env ruby1.9

require "pp"

class Integer
  def digital_sum
    to_s.split(//).map(&:to_i).inject(&:+)
  end
end

rv = []
(1..100).each{|a|
  (1..100).each{|b|
    rv << [(a**b).digital_sum, a, b]
  }
}
pp rv.sort
