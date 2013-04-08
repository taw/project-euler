#!/usr/bin/env ruby1.9

require "pp"

def p160_v1(x)
  v = 1
  (1..x).each{|i|
    v *= i
    v /= 10 while v % 10 == 0
  }
  v % 100_000
end

def p160_v2(x)
  v = 1
  c2m5 = 0
  (1..x).each{|i|
    while i%2 == 0
      c2m5 += 1
      i /= 2
    end
    while i%5 == 0
      c2m5 -= 1
      i /= 5
    end
    v = (v * i) % 100_000
  }
  raise "FAIL" unless c2m5 >= 0
  c2m5.times{
    v = (v * 2) % 100_000
  }
  v
end

def naive_counts(x)
  rv = Hash.new(0)
  (1..x).each{|i|
    d, f = 0, 0
    while i%2 == 0
      d += 1
      i /= 2
    end
    while i%5 == 0
      f += 1
      i /= 5
    end
    i %= 100_000
    rv[[i, d, f]] += 1
  }
  rv
end

def p160_v3(x)
  v = 1
  c2m5 = 0
  naive_counts(x).each{|(i, d, f), c|
    c2m5 += (d - f) * c
    c.times{
      v = (v * i) % 100_000
    }
  }
  c2m5.times{
    v = (v * 2) % 100_000
  }
  v
end

# Godawful code
def fast_counts(x)
  rv = Hash.new(0)
  z = 0
  (0..99_999).each{|i|
    next if i % 2 == 0 || i % 5 == 0
    (0..(1.0/0.0)).each{|d|
      z0 = z
      (0..(1.0/0.0)).each{|f|
        limit = x / (2**d) / (5**f)
        count = (limit - i + 100_000) / 100_000
        if count >= 1
          rv[[i,d,f]] += count
          z += count
        else
          break
        end
      }
      break if z0 == z
    }
  }
  raise "Not really #{x}/#{z}" unless x == z
  rv
end

def p160_v4(x)
  v = 1
  c2m5 = 0
  fast_counts(x).each{|(i, d, f), c|
    c2m5 += (d - f) * c
    c.times{
      v = (v * i) % 100_000
    }
  }
  c2m5.times{
    v = (v * 2) % 100_000
  }
  v
end

def fast_counts_iter(x)
  z = 0
  (0..99_999).each{|i|
    next if i % 2 == 0 || i % 5 == 0
    (0..(1.0/0.0)).each{|d|
      z0 = z
      (0..(1.0/0.0)).each{|f|
        limit = x / (2**d) / (5**f)
        count = (limit - i + 100_000) / 100_000
        if count >= 1
          yield(i,d,f,count)
          z += count
        else
          break
        end
      }
      break if z0 == z
    }
  }
  raise "Not really #{x}/#{z}" unless x == z
end

def p160_v5(x)
  v = 1
  c2m5 = 0
  fast_counts_iter(x){|i, d, f, c|
    c2m5 += (d - f) * c
    c.times{
      v = (v * i) % 100_000
    }
  }
  c2m5.times{
    v = (v * 2) % 100_000
  }
  v
end

def mulpowmod(a, b, k, m)
  #naive = a * (b ** k) % m
  rv = a
  i = 1
  bi = b
  while k != 0
    if k&i != 0
      rv = (rv * bi) % m
      k^=i
    end
    bi = (bi*bi) % m
    i *= 2
  end
  #raise "FAIL #{rv} / #{naive} [#{a} #{b} #{k} #{m}]" unless rv == naive
  rv
end

def p160_v6(x)
  v = 1
  c2m5 = 0
  fast_counts_iter(x){|i, d, f, c|
    c2m5 += (d - f) * c
    v = mulpowmod(v, i, c, 100_000)
  }
  v = mulpowmod(v, 2, c2m5, 100_000)
  v
end


p p160_v6(10 ** 12)

__END__


p p160_v4(9)
p p160_v4(10)
p p160_v4(20)
p p160_v4(1_000_000)

puts ""

p p160_v3(9)
p p160_v3(10)
p p160_v3(20)
p p160_v3(1_000_000)

# TARGET: 1_000_000_000_000

# v1: 17k  -> 4.1s

# v2: 5M   -> 6s

# v3: 5M   -> 39.2s
#     nc2  -> 76.4m
#     diff -> 37.2s
#     rest -> 2s

# v4: 5M   -> 10.8s
#     10M  -> 15s
#     100M -> 1m52s

# v5: 10M  -> 9s
#     100M -> 1m12s

# v6: 10M  -> 4s
#     100M -> 8s
#     1G   -> 15s
#     10G  -> 29s
#     100G -> 48s
#     1T   -> 
