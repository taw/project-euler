#!/usr/bin/env ruby1.9

range = (0..50)

cnt_a = 0
cnt_b = 0
cnt_c = 0

range.each{|xi|
  range.each{|yi|
    a2 = xi**2 + yi**2
    next if a2 == 0
    range.each{|xi2|
      range.each{|yi2|
        b2 = xi2**2 + yi2**2
        next if b2 == 0
        c2 = (xi-xi2)**2 + (yi-yi2)**2
        next if c2 == 0
        cnt_c += 1 if a2 + b2 == c2
        cnt_b += 1 if a2 + c2 == b2
        cnt_a += 1 if b2 + c2 == a2
      }
    }
  }
}

p [cnt_a, cnt_b, cnt_c, (cnt_a+cnt_b+cnt_c)/2.0] # 14234

