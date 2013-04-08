#!/usr/bin/env ruby1.9

require "pp"

def add_set(set, el)
  (set + [el]).uniq.sort
end

def validate?(x0, y0, pairs)
  x = x0.map{|a| a == 9 ? 6 : a}
  y = y0.map{|a| a == 9 ? 6 : a}
  pairs.each{|a,b|
    next if x.include?(a) and y.include?(b)
    next if x.include?(b) and y.include?(a)
    raise "Invailid: #{x0.inspect} #{y0.inspect} #{a}-#{b}"
  }
  true
end

def min_win_set(a, b, sets)
  rv = []
  sets.each{|x,y|
    x1, y1 = add_set(x, a), add_set(y, b)
    x2, y2 = add_set(x, b), add_set(y, a)
    rv << [x1, y1] if x1.size <= 6 && y1.size <= 6
    rv << [x2, y2] if x2.size <= 6 && y2.size <= 6
  }
  rv.uniq
end

def ext(set)
  exts = [set]
  (6 - set.size).times{
    rv = []
    exts.each{|e|
      (0..9).each{|i|
        next if e.include?(i)
        rv << add_set(e, i)
      }
    }
    exts = rv
  }
  exts.each{|e|
    yield(e)
  }
end

def ext69(set, &blk)
  ext(set, &blk)
  if set.include?(6)
    ext(set.map{|x| x == 6 ? 9 : x}, &blk)
  end
end


pairs = (1..9).map{|x| ((x**2).to_s.gsub(/9/,'6').split(//) + ['0'])[0,2].sort.map(&:to_i)}.uniq
p pairs

z = [[[], []]]
pairs.each{|a,b|
  z = min_win_set(a, b, z)
}
ze = []
z.each{|x,y|
  ext69(x){|xe|
    ext69(y){|ye|
      ze << [xe,ye].sort
    }
  }
}
ze = ze.uniq.sort
ze.each{|x,y|
  raise "Same? LOL #{x.inspect}" if x == y
  raise "INVALID" unless validate?(x, y, pairs)
#  raise "LOL" if x == [0, 5, 6, 7, 8, 9] and y == [1, 2, 3, 4, 8, 9]
  p [x, y]
}
p ze.size*2
# 1395 appears to be incorrect, and so does 2790


__END__

Haskell solution claims 1217 ???
