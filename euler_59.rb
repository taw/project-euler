#!/usr/bin/env ruby1.9

class Array
  def popularity
    ht = Hash.new(0)
    each{|k|
      ht[k]+=1
    }
    ht.to_a.map{|k,v| [v,k]}.sort.reverse
  end
end

cipher = File.read('cipher1.txt').split(/,/).map(&:to_i)

tripartition = [[], [], []]
cipher.each_with_index{|z,i|
  tripartition[i%3] << z
}

p0 = tripartition[0].popularity[0, 3]
p1 = tripartition[1].popularity[0, 3]
p2 = tripartition[2].popularity[0, 3]

def print_candidates(popularity)
  lcc = (?a..?z).map(&:ord)
  lcc.each{|a|
    p [a.chr, *popularity.map{|c, p| [(p^a).chr, c]}]
  }
end

def decode(pass, cipher)
  rv = []
  cipher.each_with_index{|z,i|
    rv << (pass[i%3]^z).chr
  }
  rv.join
end

print_candidates(p0)
puts "\n"
print_candidates(p1)
puts "\n"
print_candidates(p2)
puts "\n"

decoded = decode([?g, ?o, ?d].map(&:ord), cipher)

puts decoded

p decoded.split(//).map{|x| x.ord}.inject(&:+)
