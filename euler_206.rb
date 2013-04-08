#!/usr/bin/env ruby1.9

pattern = '1.2.3.4.5.6.7.8.9.0'
min = Math.sqrt(pattern.gsub('.', "0").to_i).to_i
max = Math.sqrt(pattern.gsub('.', "9").to_i).to_i

i = 0
(min..max).each{|x|
  i += 1
  puts "Tested #{i}" if i % 1_000_000 == 0
  xsq = x ** 2
  next unless x % 10 == 0
  next unless (x**2).to_s =~ /\A1.2.3.4.5.6.7.8.9.0\Z/
  p x
}
