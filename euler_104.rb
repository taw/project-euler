#!/usr/bin/env ruby1.9

def fib
  a,b = 1,1
  i = 1
  while true
    yield a,i
    a,b = b, a+b
    i+=1
  end
end

digits = (1..9).to_a.map(&:to_s)

fib{|x,i|
  # It barely got to 89814...
  puts i if i % 1000 == 0
  next unless x >= 100_000_000
  last = (x % 1_000_000_000).to_s
  next unless last.split(//).sort == digits
  puts "L-hit #{i}"

  # Still slow, amirite?
  first = x.to_s[0,9]

  next unless first.split(//).sort == digits
  puts "WIN!!! #{i} #{x}"
  break
}
