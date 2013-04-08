#!/usr/bin/env ruby1.9

rv = []
(1...100_000).each{|k|
  v = ""
  (1..9).each{|i|
    v += (k*i).to_s
    next if v.size < 9
    break if v.size > 9
    break if v =~ /0/
    if v.split(//).uniq.size == 9
      p [v.to_i, k, i]
      rv << [v.to_i, k, i]
    end
  }
}

p rv
p rv.max
