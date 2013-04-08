#!/usr/bin/env ruby1.9

class Integer
  def fact
    (1..self).inject(1, &:*)
  end
end

# Counting from 0
def nth_of_set(n, ordered_set)
  return [] if ordered_set.empty? and n == 0
  raise "WHAT? #{ordered_set.inspect} #{n.inspect}" if ordered_set.empty? and n != 0
  rest_perm_size = (ordered_set.size-1).fact
  a, b = n / rest_perm_size, n % rest_perm_size
  without_first = []
  ordered_set.each_with_index{|el,i|
    without_first << el unless i == a
  }
  [ordered_set[a]] + nth_of_set(b, without_first)
end

(1..6).each{|i|
  p [i, nth_of_set(i-1, (0..2).to_a)]
}

p nth_of_set(1_000_000-1, (0..9).to_a).map(&:to_s).join

