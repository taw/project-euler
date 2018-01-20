#!/usr/bin/env ruby

require "prime"

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

def solution(max)
  e = 0
  Prime.each do |prime|
    break if prime > max
    e += prime if prime.strong_right_truncatable_harshad_primes?
  end
  e
end

# p (1..1000).select(&:harshad?)
# p (1..1000).select(&:right_truncable_harshad?)
# p (1..1000).select(&:strong_harshad?)

p (1..1000000).count(&:right_truncable_harshad?)
p solution(10_000)
p solution(1_000_000)


__END__

627
90619
1188721
./euler_387.rb  1.59s user 0.13s system 86% cpu 1.980 total
