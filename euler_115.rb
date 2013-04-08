#!/usr/bin/env ruby1.9

# For example, F(3, 29) = 673135 and F(3, 30) = 1089155.

$f={}
$g={}

def g(m, n)
  $g[[m,n]] ||= if n <= m
    1
  else
    f(m, n-1)
  end
end

def f(m, n)
  $f[[m,n]] ||= if n < m
    1
  else
    (m..n).map{|i| g(m, n-i) }.inject(0, &:+) + f(m, n-1)  
  end
end

p f(3, 29) == 673135
p f(3, 30) == 1089155

(1..(1.0/0.0)).each{|i|
  v =  f(50, i)
  p [i, v]
  break if v > 1_000_000
}
