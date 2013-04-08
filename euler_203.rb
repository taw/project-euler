#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def square_free?
    prime_division.all?{|p,m| m<2}
  end
end

def pascal_triangle_rows
  row = [1]
  row_number = 1
  while true
    yield row, row_number
    row = ([0]+row).zip(row+[0]).map{|a,b| a+b}
    row_number += 1
  end
end

p [1, 2, 3, 5, 6, 7, 10, 15, 21, 35].map(&:square_free?)
p [4, 20].map(&:square_free?)

number = {}

pascal_triangle_rows{|row, i|
  row.each{|x|
    number[x] = true
  }
  break if i == 51
}

p number.keys.select(&:square_free?).inject(&:+)
