#!/usr/bin/env ruby1.9

require "mathn"
require "pp"

def dist121(n)
  rv = {0 => Rational(1,1)}
  n.times{|k|
    rv2 = Hash.new(0)
    a = Rational(1,k+2)
    b = Rational(k+1,k+2)
    rv.each{|c,p|
      rv2[c] += p * b
      rv2[c+1] += p * a
    }
    rv = rv2
  }
  rv
end

def p121(n)
  win_prob = 0
  dist121(n).each{|c,p|
    if c > n-c
      win_prob += p
    end
  }
  (1/win_prob).floor
end

pp p121(4)
pp p121(15)
