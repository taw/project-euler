#!/usr/bin/env ruby1.9

$P={}
$Q={}

# Just was red, cannot red again
def q114(x)
  $Q[x] ||= if x <= 2
    1
  else
    p114(x-1)
  end
end

# Was black or start
def p114(x)
  $P[x] ||= if x <= 2
    1
  else
    (3..x).map{|j| q114(x-j)}.inject(0, &:+) + p114(x-1)
  end
end

p p114(7)
p p114(50)
