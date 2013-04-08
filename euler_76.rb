#!/usr/bin/env ruby1.9

$memo = {}
def p76(n, max_digits=n-1)
  unless $memo[[n, max_digits]]
    rv = if max_digits == 1 or n == 0
      1
    elsif n >= max_digits
      p76(n-max_digits, max_digits) + p76(n, max_digits-1)
    else
      p76(n, max_digits-1)
    end
    puts "P[#{n}, #{max_digits}] = #{rv}"
    $memo[[n, max_digits]] = rv
  end
  $memo[[n, max_digits]]
end

p p76(5)
p p76(100)
