#!/usr/bin/env ruby1.9

require "pp"

base_exp = File.readlines('base_exp.txt').map{|line| line.chomp.split(/,/).map(&:to_i)}

# All logs vaguely around ~~ 6919901

p base_exp.each_with_index.map{|(base, exp), i|
  [Math.log(base) * exp, i+1]
}.max
