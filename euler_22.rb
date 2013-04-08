#!/usr/bin/env ruby1.9

class String
  def num_value
    split(//).map{|x| x.ord - "A".ord + 1}.inject(&:+)
  end
end

names = File.read("names.txt").split(/,/).map{|n| n.gsub(/"/, '')}.sort

ac = 0
names.each_with_index{|n,j|
  x = n.num_value * (j+1)
  p x if n == "COLIN"
  ac += x
}
p ac
