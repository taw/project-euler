#!/usr/bin/env ruby1.9

# raise 'Slow as fuck'

seen = {}
v122 = {1 => 0}
sets = [[1]]

target = 200

# Binary multiplication takes <= 2 * log2(n) + c, amirite?
# Therefore I pressume result <= 15

while true
  puts "#{sets.size} / #{v122.keys.size}"
  sets.dup.each{|set|
    set.each{|a|
      set.each{|b|
        sum = a+b
        next if sum > target
        next unless sum > set[-1] # Do not generate small ones
        new_set = set + [sum]
        next if seen[new_set]
        sets << new_set
        v122[sum] = [v122[sum], new_set.size-1].compact.min
        seen[new_set] = true
      }
    }
  }
  break if v122.keys.size == target
end

#p seen
p v122.to_a.sort
p v122.values.inject(&:+)
#p sets

__END__

1 / 1
2 / 2
4 / 4
10 / 7
35 / 12
170 / 21
1083 / 36
8582 / 62
81772 / 105
914983 / 169     <- that's 10, max is 15...
