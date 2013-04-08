#!/usr/bin/env ruby1.9

require "pp"

class String
  def palindrome?
    self == reverse
  end
end

class Integer
  def palindrome?
    to_s.palindrome?
  end
end

def sum_consecutive_squares_from_1
  e = 0
  (1..(1.0/0.0)).each{|i|
    e += i*i
    yield(e, i)
  }
end

def sum_consecutive_squares(limit)
  scs = [0]

  sum_consecutive_squares_from_1{|a, i|
    scs << a
    break if i**2 > limit
  }

  (2...scs.size).each{|i|
    (i-2).downto(0).each{|j|
      e = scs[i] - scs[j]
      break if e > limit
      yield [e, i, j]
    }
  }
end

def scs_palindromes(limit)
  sum_consecutive_squares(limit){|e,i,j|
    next unless e.palindrome?
    # p [e, j+1, i, (j+1 .. i).map{|z| z**2}.inject(&:+), (j+1 .. i).map{|z| z}, (j+1 .. i).map{|z| z**2}]
    yield e
  }
end

res = []
scs_palindromes(10**8){|a|
  res << a
}
res.uniq!
p [res.size, res.inject(&:+)] # 1000 -> [11, 4164]

__END__
[166, 2906969179]
