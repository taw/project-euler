#!/usr/bin/env ruby1.9

class Integer
  def digits
    to_s.split(//).map(&:to_i)
  end
  
  def sum_digits_to_5th
    digits.map{|x| x**5}.inject(&:+)
  end
  # 9 ** 5
  
end

ac = 0
(2..1_000_000).each{|i|
  next unless i == i.sum_digits_to_5th
  p i
  ac += i
}
p ac
