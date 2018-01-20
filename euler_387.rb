#!/usr/bin/env ruby

require "prime"

class Integer
  def digit_sum
    to_s.chars.map(&:to_i).sum
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

p (1..1000).select(&:harshad?)
p (1..1000).select(&:right_truncable_harshad?)
p (1..1000).select(&:strong_harshad?)


p (1..10000).select(&:strong_right_truncatable_harshad_primes?).sum


# You are given that the sum of the strong, right truncatable Harshad primes less than 10000 is 90619.
