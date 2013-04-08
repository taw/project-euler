#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def sumdiv
    prime_division.map{|p,k|
      (0..k).map{|i| p**i}.inject(0, &:+)
    }.inject(1, &:*) - self
  end
end

$sd = Hash.new{|ht,k| ht[k] = k.sumdiv}

def p95(limit)
  (1..limit).each{|x|
    chain = [x]
    seen = {x => true}
    while true
      chain << $sd[chain[-1]]
      if seen[chain[-1]]
        if chain[0] == chain[-1]
          p [:win, chain.size-1, *chain[0..-2]] if chain.size-1 > 2
        else
          #p [:fail, *chain]
        end
      elsif chain[-1] == 0 || chain[-1] > limit
        #p [:fail, *chain]
      else
        seen[chain[-1]] = true
        next
      end
      break
    end
  }
end

p95(1_000_000)
