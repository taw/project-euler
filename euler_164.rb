#!/usr/bin/env ruby1.9

$p={}
def p164(a,b,todo)
  $p[[a,b,todo]] ||= if todo == 0
    1
  else
    (0..(9-a-b)).map{|i|
      p164(b, i, todo-1)
    }.inject(0, &:+)
  end
end

def solve_slow(limit)
  c = 0
  p (10**(limit-1)..(10**limit - 1))

  (10**(limit-1)..(10**limit - 1)).each{|i|
    digits = i.to_s.split(//).map(&:to_i)
    c += 1 if (0..digits.size-3).all?{|j|
      digits[j] + digits[j+1] + digits[j+2] <= 9
    }
  }
  c
end

def solve_fast(limit)
  (1..9).map{|a|
    (0..9).map{|b|
      p164(a, b, limit - 2)
    }
  }.flatten.inject(0, &:+)
end

p solve_slow(5)
p solve_fast(5)
p solve_fast(20)
