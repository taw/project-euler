#!/usr/bin/env ruby1.9

def last_3_digits
  (0..9).each{|d10|
    (0..9).each{|d9|
      next unless d9 != d10
      (0..9).each{|d8|
        next unless d8 != d9 and d8 != d10
        next unless (d8*100+d9*10+d10) % 17 == 0
        yield([d8, d9, d10])
      }
    }
  }
end

def last_4_digits
  last_3_digits{|ds|
    d8, d9, d10 = ds
    ((0..9).to_a - ds).each{|d7|
      next unless (d7*100+d8*10+d9) % 13 == 0
      yield([d7, d8, d9, d10])
    }
  }
end

def last_5_digits
  last_4_digits{|ds|
    d7, d8, d9, d10 = ds
    ((0..9).to_a - ds).each{|d6|
      next unless (d6*100+d7*10+d8) % 11 == 0
      next unless d6 == 0 or d6 == 5 # [d4 d5 d6] divides 5, early check
      yield([d6, d7, d8, d9, d10])
    }
  }
end

def last_6_digits
  last_5_digits{|ds|
    d6, d7, d8, d9, d10 = ds
    ((0..9).to_a - ds).each{|d5|
      next unless (d5*100+d6*10+d7) % 7 == 0
      yield([d5, d6, d7, d8, d9, d10])
    }
  }
end

def last_7_digits
  last_6_digits{|ds|
    d5, d6, d7, d8, d9, d10 = ds
    ((0..9).to_a - ds).each{|d4|
      next unless d4.even? # [d2 d3 d4] divides 2, early check
      # Divisibility by 5 already checked on step last_5
      yield([d4, d5, d6, d7, d8, d9, d10])
    }
  }
end

def last_8_digits
  last_7_digits{|ds|
    d4, d5, d6, d7, d8, d9, d10 = ds
    ((0..9).to_a - ds).each{|d3|
      next unless (d3*100+d4*10+d5) % 3 == 0
      yield([d3, d4, d5, d6, d7, d8, d9, d10])
    }
  }
end

def all_digits
  last_8_digits{|ds|
    d3, d4, d5, d6, d7, d8, d9, d10 = ds
    a, b = (0..9).to_a - ds
    yield([a, b, *ds]) if a != 0
    yield([b, a, *ds]) if b != 0
  }
end

s = 0
all_digits{|x|
  p x
  s += x.map(&:to_s).join.to_i
}
p s
