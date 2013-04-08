#!/usr/bin/env ruby

require "mathn"

class Integer
  def rad
    prime_division.map{|p,k|
      p
    }.inject(1, &:*)
  end
end

(1..100000).map{|n|
  [n.rad, n]
}.sort.each_with_index{|(nr, n), k|
  p [n, nr, k+1]
}
