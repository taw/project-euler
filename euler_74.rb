#!/usr/bin/env ruby1.9

$f = {}

(0..9).each{|i| $f[i.to_s] = (1..i).inject(1, &:*)}

class Integer
  def df
    to_s.split(//).map{|x| $f[x]}.inject(&:+)
  end
  
  def df_cycle_length
    seen = {}
    a = self
    count = 0
    until seen[a]
      seen[a] = true
      a = a.df
      count += 1
    end
    count
  end
end

# p 1.df_cycle_length
# p 169.df_cycle_length
# p 145.df_cycle_length

c60 = []
(1...1_000_000).each{|i|
  cl = i.df_cycle_length
  p [i, cl] if cl > 60
  c60 << i if cl == 60
}
p c60
p c60.size

