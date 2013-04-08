#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def cuts
    (lcuts + rcuts).uniq
  end
  def lcuts
    z = to_s
    (0...z.size).map{|i| z[0, i+1]}.map(&:to_i)
  end
  def rcuts
    z = to_s
    (0...z.size).map{|i| z[i..-1]}.map(&:to_i)
  end  
  def prime?
    Prime.prime?(self)
  end
end

# puts "RT-primes"
# (1..100_000).each{|i|
#   p i if i.rcuts.all?(&:prime?)
# }
# 
# puts "\nLT-primes"
# (1..10_000).each{|i|
#   p i if i.lcuts.all?(&:prime?)
# }

(1..1_000_000).each{|i|
  p i if i.cuts.all?(&:prime?)
}
