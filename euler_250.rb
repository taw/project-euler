#!/usr/bin/env ruby1.9

require "pp"

class Integer
  def powmod(n, m)
    rv = 1
    xi = self%m
    while n != 0
      rv = (rv*xi) % m if n&1 == 1
      n >>= 1
      xi = (xi*xi) % m
    end
    rv
  end
end
  
def interesting_set(n)
  ht = Hash.new(0)
  (1..n).map{|i|
    ht[i.powmod(i, 250)] += 1
    
  }
  ht.to_a.sort
end

# Self-test OK
# 100.times {
#   a, b, c = rand(1000), rand(1000), rand(1000)
#   p [a, b, c, a.powmod(b, c) == a**b % c]
# }
# 


def subset_sums_mod(m, set)
  return [1] + [0]*(m-1) if set.empty?
  n, c = set[0]
  rest = set[1..-1]

  ss = subset_sums_mod(m, rest)

  rv = [0]*m
  (0..c).each{|i|
    ss.each_with_index{|count, sub|
#      puts "HAI #{[sub, count, ss].inspect}"
      new_m = (sub + i*n) % m
      rv[new_m] += count
    }
  }
  rv
end

#pp subset_sums_mod(10, [[1, 2], [2, 1]])

pp subset_sums_mod(250, interesting_set(250250))

# 2817079230619906216524313205525766723463606656279493466653117649222997669660135144321918788390160582360415138022597672311582285323409396346505493637231636394600804636412709291054964308595040589938283439028132383166829286781704506004993266453770096308134472385532894000208249594850173391258358278589170978925503392253732018584417258266883091597323702681688961822334968234460909608841251191544191058507687658131664653954001372903561965373717250784229595220740195058000352
# 0740195058000352
