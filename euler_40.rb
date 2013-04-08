#!/usr/bin/env ruby1.9

def ith(u)
  i = u-1 # off by 1 conversion
  j = 1
  while true
    js = j.to_s
    if i >= js.size
      i -= js.size
      j += 1
    else
      return js[i, 1].to_i
    end
  end
end

(1..12).each{|i|
  p [i, ith(i-1)]
}

p [1, 10, 100, 1000, 10_000, 100_000, 1_000_000].map{|i| ith(i)}
p [1, 10, 100, 1000, 10_000, 100_000, 1_000_000].map{|i| ith(i)}.inject(&:*)
