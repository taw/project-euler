#!/usr/bin/env ruby1.9

def pandigital_pair?(a,b)
  c = a * b
  return nil unless [a,b,c].map(&:to_s).join.split(//).sort == ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  return c
end

products = []
(1..10000).each{|a|
  (1..a).each{|b|
    break if [a, b, a*b].map(&:to_s).join.size > 9
    c = pandigital_pair?(a, b)
    next unless c
    puts "#{a} x #{b} = #{c}"
    products << c
  }
}
p products.uniq
p products.uniq.inject(&:+)
