#!/usr/bin/env ruby1.9

class String
  def palindrome?
    self == reverse
  end
end

class Integer
  def palindrome?(base)
    to_s(base).palindrome?
  end
  
  def bipalindrome?
    palindrome?(2) and palindrome?(10)
  end
end

p (1..1_000_000).select(&:bipalindrome?).inject(&:+)
