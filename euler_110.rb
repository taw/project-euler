#!/usr/bin/env ruby1.9

require "mathn"

class Integer
  def p110_v5
    i = 1
    prime_division.each{|p,k|
      i *= 2*k+1
    }
    (i+1)/2
  end
end


def verify_solution(x)
  target = 4_000_000
  u = x.p110_v5
  p (u/target).to_f
  x.p110_v5 > target
end

# primes = Prime.each(50).to_a
# solution_zero = primes.inject(&:*)
# p verify_solution(solution_zero)
# p solution_zero.to_s.size
# p solution_zero

(1..20).each{|a|
  (1..10).each{|b|
    (1..10).each{|c|
      (1..5).each{|d|
        s = 2**a * 3**b * 5**c * 7**d
        u = nil
        ps = []
        Prime.each{|p|
          next if p <= 7
          ps << p
          s *= p
          u = s.p110_v5
          break if u > 4_000_000
        }
        next if s > 10685862914126400
        puts [s, (u/4_000_000).to_f].inspect
        puts [a,b,c,d,ps].inspect
      }
    }
  }
}

solution_zero = 2**3 * 3**3 * 5**2 * 7**2 * 11 * 13 * 17 * 19 * 23 * 29 * 31 * 37
p verify_solution(solution_zero)
p solution_zero.to_s.size
p solution_zero

__END__

16
9350130049860600
