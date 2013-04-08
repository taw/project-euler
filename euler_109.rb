#!/usr/bin/env ruby1.9

all = {}
doubles = {}

all["z"] = 0
all["s25"] = 25
all["d25"] = 50
doubles["d25"] = 50
(1..20).each{|i|
  all["s#{i}"] = i
  all["d#{i}"] = i*2
  doubles["d#{i}"] = i*2
  all["t#{i}"] = i*3
}

number_of_checkouts = Hash.new(0)

all.each{|x,xi|
  all.each{|y,yi|
    doubles.each{|z,zi|
      next unless x >= y # duplicate removal
      score = xi+yi+zi
      number_of_checkouts[score] += 1
    }
  } 
}

lt_100 = 0
number_of_checkouts.to_a.sort.each{|score, cnt|
  lt_100 += cnt if score < 100
  p [score, cnt]
}
p lt_100
