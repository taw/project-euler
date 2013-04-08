#!/usr/bin/env ruby1.9

require "mathn"

def naive_finder
  a=[]
  b={}

  (1..10_000_000).each{|i|
    a << [2*i*(i-1), i]
    b[i*(i-1)] = i
  }

  a.each{|e,i|
    next unless b[e]
    p [i, b[e], b[e]-i, e]
  }
end

def magic_finder(a, e, b, mult)
  ax = (mult * a).to_i
  bx = (mult * b).to_i
  r = 100
  (-r..r).each{|i|
    (-r..r).each{|j|
      a2 = ax+i
      b2 = bx+j
      #p ["Testing", a2, b2]
      #p [2*a2*(a2-1), (a2+b2)*(a2+b2-1)]
      return [a2, a2+b2, b2] if 2*a2*(a2-1) == (a2+b2)*(a2+b2-1)
    }
  }
  return nil
end

#naive_finder

results = [
#  [1, 1, 0, 0],
  [3, 4, 1, 12],
  [15, 21, 6, 420],
  [85, 120, 35, 14280],
  [493, 697, 204, 485112],
  [2871, 4060, 1189, 16479540],
  [16731, 23661, 6930, 559819260],
  [97513, 137904, 40391, 19017375312],
  [568345, 803761, 235416, 646030941360],
  [3312555, 4684660, 1372105, 21946034630940],
  [19306983, 27304197, 7997214],
  [112529341, 159140520, 46611179],
]

100.times{|i|
  mult = results[-1][1].to_f / results[-2][1].to_f
  rv = magic_finder(*results[-1][0..2], mult)
  p rv
  p rv[1] > 10**12
  results << rv
  break unless rv
}
