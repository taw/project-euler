#!/usr/bin/env ruby1.9

require "mathn"

class Array
  def permutations
    if empty?
      yield []
    else
      each_with_index{|a,i|
        with_gap = self[0, i] + self[(i+1)..-1]
        with_gap.permutations{|p|
          yield [a] + p
        }
      }
    end
  end
end

def p239_by_enumeration(red, blue)
  rv = [0] * (red+1)
  (0...red+blue).to_a.permutations{|perm|
    k = (0...red).select{|i| perm[i] == i}.size
    rv[k] += 1
  }
  rv
end

$p239_memo = {}
def p239(red, blue)
  return $p239_memo[[red, blue]] if $p239_memo[[red, blue]]
  if red < 0 || blue < 0
    # Nonsense-values, ignore those please
    return []
  elsif red > 0
    rv = []
    
    ca = p239(red-1, blue)  .map{|x|x}         # Correct red
    cb = p239(red-2, blue+1).map{|x|x*(red-1)} # Incorrect red: red[k] gone, red[0] becomes blue
    cc = p239(red-1, blue)  .map{|x|x*blue}    # Blue: one blue gone, but red[0] becomes blue

    ca.each_with_index{|v,i| rv[i+1]||=0; rv[i+1] += v}
    cb.each_with_index{|v,i| rv[i]||=0; rv[i] += v}
    cc.each_with_index{|v,i| rv[i]||=0; rv[i] += v}
  else
    rv = [(1..blue).inject(&:*)]
  end
#  puts "P(#{red}, #{blue}) = #{rv.inspect}"
  $p239_memo[[red, blue]] = rv
  rv
end

p p239_by_enumeration(2, 5)

p p239(1, 1)

p p239(2, 5)

x = p239(25, 75)
xe = x.inject(&:+)

x.each_with_index{|xi, i|
  printf "%d -> %.12f\n", i, (xi/xe).to_f
}


# FAIL???
