#!/usr/bin/env ruby1.9

$destination = {1 => 1, 89 => 89}

def destination(x)
  if $destination[x]
    $destination[x]
  else
    rv = destination(x.to_s.split(//).map{|x|x.to_i**2}.inject(0, &:+))
    $destination[x] = rv if x < 10_000
    rv
  end
end

vs = Hash.new(0)
(1...10_000_000).each{|x|
  vs[destination(x)] += 1
}
p vs
