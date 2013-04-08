#!/usr/bin/env ruby1.9

require "mathn"

class Array
  def sum
    inject(0, &:+)
  end
end

def p249_v0(limit)
  sums = [[]]
  Prime.each(limit){|p|
    sums += sums.map{|el| [p, *el]}
  }
  sums.map(&:sum).count(&:prime?)
end

def p249_v1(limit)
  sums = {0 => 1}
  Prime.each(limit){|p|
    new_sums = Hash.new(0)
    sums.each{|e,c|
      new_sums[e] += c
      new_sums[e+p] += c
    }
    sums = new_sums
  }
  rv = 0
  sums.each{|e,c|
    rv += c if e.prime?
  }
  rv
end

def p249_v2(limit)
  sums = Hash.new(0)
  sums[0] = 1
  Prime.each(limit){|p|
    new_sums = sums.dup
    sums.each{|e,c|
      new_sums[e+p] = (new_sums[e+p] + c) % 10**16
    }
    sums = new_sums
  }
  rv = 0
  sums.each{|e,c|
    rv += c if e.prime?
  }
  (rv % 10**16)
end

def p249_v3(limit)
  sums = [1]
  Prime.each(limit){|p|
    new_sums = sums.dup
    sums.each_with_index{|c,e|
      new_sums[e+p] = ((new_sums[e+p]||0) + (c||0)) % 10**16
    }
    sums = new_sums
  }
  rv = 0
  sums.each_with_index{|c,e|
    rv += c if e.prime?
  }
  (rv % 10**16)
end

c = ARGV[0].to_i
#p p249_v1(c)
p p249_v3(c)

#         v1         v2      v3
# 1k ->            12.5s / 11.4s
# 2k -> 2m13.4s / 1m22.7s/ 1m1.2s
# 3k ->                  / 3m5.7s
# 4k ->                  / 6m38.7
# 5k ->                  / 12m53s

# 9275262564250418 FTW!
