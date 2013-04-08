#!/usr/bin/env ruby1.9

class String
  def num_value
    split(//).map{|x| x.ord - "A".ord + 1}.inject(&:+)
  end
end

words = File.read('words.txt').split(/,/).map{|x| x.gsub(/"/, '')}.map(&:num_value)
wm = words.max

ht = Hash.new(0)

words.each{|i|
  ht[i] += 1
}

ac = 0
(0..100).each{|n|
  t = n*(n+1)/2
  break if t > wm
  ac += ht[t]
}
p ac
