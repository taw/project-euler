#!/usr/bin/env ruby1.9

require "mathn"

class Array
  include Comparable
end

class Integer
  def phi
    all = self
    prime_division.each{|p,k|
     all -= (all/p) # painful, but seems to work
    }
    all
  end
  
  def digit_perm?(x)
    to_s.split(//).sort == x.to_s.split(//).sort
  end
end

best = [1.0/0.0, nil, nil]

(2...10_000_000).each{|i|
  ip = i.phi
  sc = [i.to_f/ip, i, ip]
  if sc < best
    if i.digit_perm?(ip)
      best = sc
      p sc
    end
  end 
}

p best
