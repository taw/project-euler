#!/usr/bin/env ruby1.9

require "pp"

$roman_translations = [
  ["M" , 1000],
  ["CM" , 900],
  ["D" , 500],
  ["CD" , 400],
  ["C" , 100],
  ["XC" , 90],
  ["L" , 50],
  ["XL" , 40],
  ["X" , 10],
  ["IX" , 9],
  ["V" , 5],
  ["IV" , 4],
  ["I" , 1],
]

class String
  def to_arabic
    rv = 0
    i = 0
    while true
      break if i == size
      tick = false
      $roman_translations.each{|t,a|
        if self[i, t.size] == t
          rv += a
          i += t.size
          tick = true
          break
        end
      }
      raise "Cannot parse: #{self} @ #{i}" unless tick
    end
    rv
  end
end

class Integer
  def to_roman
    rv = ""
    i = self
    $roman_translations.each{|t,a|
      while i >= a
        rv << t
        i -= a
      end
    }
    raise "FAIL: #{self} / #{rv} + #{i}" unless i == 0
    rv
  end
end

roman = File.readlines('roman.txt').map(&:chomp)

s = 0
roman.each{|r|
  enc_savings = r.size - r.to_arabic.to_roman.size
  s += enc_savings
  #p [r, r.to_arabic, r.to_arabic.to_roman]
}
p s
