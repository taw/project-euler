#!/usr/bin/env ruby1.9

class Integer
  def x7
    a, r = self, 1
    while a > 0
      r *= (a%7)+1
      a /= 7
    end
    r
  end
end

def pascal_triangle_rows_m7
  row = [1]
  row_number = 1
  while true
    yield row, row_number
    row = ([0]+row).zip(row+[0]).map{|a,b| (a+b)%7}
    row_number += 1
  end
end

def explore!
  pascal_triangle_rows_m7{|row,i|
  #  p row.count{|c| c != 0}
    row = row.map{|x| x == 0 ? '.' : "#{x}" }
    puts (' ' * (100 - row.size)) + row.join(' ') + "  - #{(i-1).to_s(7)}"
    break if i == 100
  }
end

def pascal_triangle_not_7
  (1..(1.0/0.0)).each{|n|
    yield((n-1).to_s(7).split(//).map{|d| d.to_i+1}.inject(1, &:*), n)
  }
end

def pascal_triangle_not_7_fast
  (1..(1.0/0.0)).each{|n|
    yield((n-1).x7, n)
  }
end

def p148_naive(limit)
  sum = 0
  pascal_triangle_rows_m7{|r,i|
    sum += r.count{|c| c != 0}
    break if limit == i
  }  
  sum
end

def p148_v2(limit)
  sum = 0
  pascal_triangle_not_7{|c,i|
    sum += c
    break if limit == i
  }  
  sum
end

def p148_v3(limit)
  sum = 0
  pascal_triangle_not_7_fast{|c,i|
    sum += c
    break if limit == i
  }  
  sum
end

def p148_v4(limit)
  sum = 0
  (0...limit).each{|n|
    sum += n.x7
  }
  sum
end

def p148_v5(limit)
  sum = 0
  n = 0
  while n+7 <= limit
    sum += 28 * n.x7
    n += 7
  end
  while n+1 <= limit
    sum += n.x7
    n += 1
  end
  sum
end

def p148_v6(limit)
  sum = 0
  n = 0
  while n+49 <= limit
    sum += 28 * 28 * n.x7
    n += 49
  end
  while n+7 <= limit
    sum += 28 * n.x7
    n += 7
  end
  while n+1 <= limit
    sum += n.x7
    n += 1
  end
  sum
end

# v2 - 16s / 1M
# v3 - 1.7s / 1M

# v3  19s  / 10M
# v4  16s  / 10M
# v5  2.2s / 10M

# v5 24s / 100M
# v6 3.5s / 100M

#p p148_v5(100_000_000)
#p p148_v6(100_000_000)

p p148_v6(1_000_000_000)
