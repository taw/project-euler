#!/usr/bin/env ruby1.9

require "pp"

class Integer
  def sd
     x, e = self, 0
     while x != 0
       e += x%10
       x /= 10
     end
     e
  end
end

rv = []

# 8 ** 3 -> 512 -> 8

(1..10000).each{|i|
  (1..40).each{|j|
    ijsd = (i**j).sd
    rv << [i**j, i, j] if ijsd == i and i**j >= 10
  }
}

rv.sort.each_with_index{|(ij,i,j),k|
  puts "#{k+1}: #{i}/#{j} #{ij}"
}


30: 63/8 248155780267521

