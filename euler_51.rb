#!/usr/bin/env ruby1.9

require "mathn"

def lastdigit(a,x)
  c = 0
  10.times{|y|
    c += 1 if (a+y*x).prime?
  }
  p [a,x,c] if c >= 8
end

def nextdigit(a,x,n)
  if n == 0
    lastdigit(a, x) if x != 0
  else
    a *= 10
    x *= 10
    n -= 1
    10.times{|u|
      nextdigit(a+u, x, n)
    }
    nextdigit(a, x+1, n)
  end
end

nextdigit(0,0,7)

__END__

[20303, 101010, 8]
[40609, 101010, 8]
[109, 111000, 8]
[857, 111000, 8]

user	4m41.672s


Estimated runtime for 7 digits - 2h+

[2090021, 101100, 8] - apparently not minimal
[4004509, 110010, 8]

Actually 121313 + 101010 works :-/
