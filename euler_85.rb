#!/usr/bin/env ruby1.9

require "pp"

def divisions(x)
  x*(x+1)/2
end

def forever(start, &blk)
  (start..(1.0/0.0)).each(&blk)
end

# p [divisions(1), 1]
# p [divisions(2), 3]
# p [divisions(3), 6]
# p [divisions(4), 4+3+2+1]
# p [divisions(5), 5+4+3+2+1]

def find_near_solutions(near_value)
  forever(1).each{|a|
    ad = divisions(a)
    if ad > near_value
      yield(a,1,ad)
      break
    end
    forever(1).each{|b|
      ad_bd = ad * divisions(b)
      yield(a,b,ad_bd)
      if ad_bd > near_value
        break
      end
    }
  }
end

def find_nearest_solutions(near_value)
  rv = []
  find_near_solutions(near_value){|a,b,area|
    rv << [(area - near_value).abs, a, b, area]
  }
  rv.sort
end

pp find_nearest_solutions(2_000_000)
