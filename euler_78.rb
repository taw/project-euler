#!/usr/bin/env ruby1.9

require "pp"

$P = {}

def p78_v1(x, min_size=x)
  min_size = x if min_size > x
  $P[[x, min_size]] ||= if x == 0
    1
  elsif min_size == 1
    1
  else
    p78_v1(x, min_size-1) + p78_v1(x - min_size, min_size)
  end
end

$P2={}
def p78_v2(x, m=x)
  ($P2[x]||={})[m] ||= if x == 0 or m == 1
    1
  else
    nx = x - m
    p78_v2(x, m-1) + p78_v2(nx, [nx, m].min)
  end
end

$P3=[]
def p78_v3(x, m=x)
  ($P3[x]||=[])[m] ||= if x == 0 or m == 1
    1
  else
    nx = x - m
    p78_v3(x, m-1) + p78_v3(nx, [nx, m].min)
  end
end

$P4=[]
def p78_v4(x, m=x)
  ($P4[x]||=[])[m] ||= if x == 0 or m == 1
    1
  else
    nx = x - m
    (p78_v4(x, m-1) + p78_v4(nx, [nx, m].min)) % 1000_000
  end
end

def p78_v4_verbose(x, m=x, verbose=false)
  rv = ($P4[x]||=[])[m] ||= if x == 0 or m == 1
    1
  else
    nx = x - m
    (p78_v4(x, m-1, verbose) + p78_v4(nx, [nx, m].min, verbose)) # % 1000_000
  end
  puts "Testing [#{x} / #{m}] = #{rv}" if verbose
  rv
end

def benchmark(limit)
  (1..limit).each{|i|
    x = yield(i)
    win = x % 1000_000 == 0
    p [i, x, win]
    break if win
  }
end

def p78_v5(limit)
  $P5 = [[1]]
  (1..limit).each{|x|
    #c = []
    $P5[x] = [nil, 1]
    e = 1
    (2..x).each{|m|
      nx = x - m
      m2 = [nx, m].min
      #c << [nx, m2]
      e += $P5[nx][m2] % 1000_000
      $P5[x][m] = e
    }
    yield($P5[x][x] % 1000_000, x)
  }
end

# p78_v5(1_000_000){|x, i|
#   win = (x % 1000_000) == 0
#   p [i, x, win]
#   break if win
# }

# column-oriented rather than row-oriented, for O(n) memory rather than O(n^2)
def p78_v6(limit)
  out = []
  column = [1] + [0] * (limit)
  (1..limit).each{|k|
    new_column = column[0, k]
    (k..limit).each{|n|
      c = column[n] + new_column[n-k]
      c -= 1_000_000 if c >= 1_000_000
      new_column << c
    }
    column = new_column
    out << column[k] % 1_000_000
    puts "#{k}: #{out[-1]}"
    break if out[-1] == 0
  }
end

p78_v6(100_000)

__END__

# v1  -   500 -> 18s
# v2  -   500 -> 0.4s
# v2  -  2000 -> 7s
# v2  -  5000 -> 2m2s
# v3  -  5000 -> 1m24s
# v4  -  5000 -> 1m27s :-/
# v4  - 10000 -> stack fail
# v5  -  5000 -> 1m17s
# v5a -  5000 -> 26s
# v5b -  5000 -> 1m24s FFFFFFFFFFFFFUUUUUUUUUUUUUUUUUU
# v5a - 10000 -> 3m28s
# v5a/1.8 -> 54s

# v6 - 10000 -> 21s (16s user)
# v6 - 20000 -> 1m19s (1m3s user)
# v6 - 100000 -> 43m51s (20m30s user, 55374)

(1..(1.0/0.0)).each{|i|
  x = p78_v1(i)
  win = x % 1000_000 == 0
  p [i, x, win]
  break if win
}

# [500, 2300165032574323995027, false]
# [500, 995027, false]

# [1461, 371934900939102477916959218389244857418, false]
# 7m43s

# [5000, 169820168825442121851975101689306431361757683049829233322203824652329144349, false]
# [5000, 144349, false]

# [6545, 341890, false]
# ./euler_78.rb:44:in `p78_v4': stack level too deep (SystemStackError)

# [599, 270000, false]
# [776, 950000, false]
# [1949, 780000, false]
# [2499, 180000, false]
# [4989, 680000, false]
# [7964, 710000, false]
# [8249, 290000, false]
# [11224, 300000, false]
# [12499, 180000, false]
# [12624, 210000, false]
# [14574, 120000, false]
# [16274, 510000, false]
# [18474, 420000, false]

# 600 / 777 / 1950 / 2500 / 4990 / 7965 / 8250 / ...
# 10 hits / 13k, expected 1.3, so ... expected result of about 150k

# [18494, 353055, false]
# 246m
# OOM
