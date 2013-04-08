#!/usr/bin/env ruby1.9

require "mathn"

def problem_47(k)
  i = 1
  while true
    if (0...k).all?{|j| (i+j).prime_division.size >= k}
      return i
    end
    i+=1
  end
end

p problem_47(2)
p problem_47(3)
p problem_47(4)
