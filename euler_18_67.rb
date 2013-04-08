# 7273
t = File.readlines('euler_67').map{|r| r.split.map(&:to_i)}; (1...t.size).each{|i| (0..i).each{|j| t[i][j] += [(j > 0 ? t[i-1][j-1] : nil), (j<=i ? t[i-1][j] : nil)].compact.max  }}; p t[-1].max
