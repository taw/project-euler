#!/usr/bin/env ruby

require "prime"
require "set"

class Integer
  def digit_sum
    i = self
    e = 0
    while i > 0
      e += (i % 10)
      i /= 10
    end
    e
  end

  def harshad?
    return false if self == 0
    self % digit_sum == 0
  end

  def right_truncable_harshad?
    return false unless harshad?
    if self < 10
      true
    else
      (self/10).right_truncable_harshad?
    end
  end

  def strong_harshad?
    harshad? and (self/digit_sum).prime?
  end

  def strong_right_truncatable_harshad_primes?
    return false unless prime?
    truncation = (self/10)
    truncation.strong_harshad? and truncation.right_truncable_harshad?
  end
end

def setup_rth(iterations)
  known = (1..9).select(&:right_truncable_harshad?).to_set
  level = 1

  iterations.times do
    level *= 10
    next_known = Set[]
    known.each do |truncation|
      (0..9).each do |i|
        candidate = truncation*10 + i
        next_known << candidate if candidate.harshad?
      end
    end
    known += next_known
  end
  known
end

def solution(max)
  e = 0
  RightTruncableHarshad.each do |truncation|
    next unless truncation.strong_harshad?
    (0..9).each do |i|
      num = truncation*10 + i
      next if num > max
      next unless num.prime?
      e += num
    end
  end
  e
end

RightTruncableHarshad = setup_rth(6)

# p (1..1000).select(&:harshad?)
# p (1..1000).select(&:right_truncable_harshad?)
# p (1..1000).select(&:strong_harshad?)

p RightTruncableHarshad.count{|x| x <= 1000000 }

p solution(10_000)
p solution(1_000_000)


__END__

627
90619
1188721
./euler_387.rb  1.59s user 0.13s system 86% cpu 1.980 total
