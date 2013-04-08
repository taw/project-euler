#!/usr/bin/env ruby1.9

class Integer
  def digits_collection
    to_s.split(//).sort
  end
  def multiplies_ok?
    (1..6).map{|x|
      (self*x).digits_collection
    }.uniq.size == 1
  end
end

(1..1_000_000).each{|i|
  p i if i.multiplies_ok?
}
