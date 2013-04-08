#!/usr/bin/env ruby1.9

class Integer
  def reversible?
    sts = self.to_s.reverse
    return false if sts[0,1] == '0'
    (self + sts.to_i).to_s !~ /[02468]/
  end
end

def reversible_upto(k)
  s = 0
  (1..k).each{|i|
    s += 1 if i.reversible?
  }
  s
end

(1..9).each{|i|
  puts "#{i} -> #{reversible_upto(10**i)}"
}
