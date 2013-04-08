#!/usr/bin/env ruby

def equispaced_solutions
  meta_total = 0
  (1..15).each{|m|
    e = 1.0
    total_xi = 0
    m.times{|i|
      xi = 2.0 * (i+1).to_f / (m+1)
      total_xi += xi
      e *= xi ** (i+1)
    }
    p [m, e, total_xi]
    meta_total += e.floor
  }
  p meta_total - 1
end

def brute_force_p2
  emax = 0
  vec = 0
  1_000_000.times{
    x2 = rand * 2.0
    x1 = 2.0 - x2
    e = (x2 ** 2) * x1
    if e > emax
      vec = [x1, x2]
      emax = e
    end
  }
  p emax
  p vec
end

def brute_force_p3
  emax = 0
  vec = 0
  1_000_000.times{
    x3 = rand * 3.0
    x2 = rand * (3.0 - x3)
    x1 = 3.0 - x2 - x3
    e = (x3 ** 3) * (x2 ** 2) * x1
    if e > emax
      vec = [x1, x2, x3]
      emax = e
    end
  }
  p emax
  p vec
end

def brute_force_p4
  emax = 0
  vec = 0
  1_000_000.times{
    x4 = rand * 4.0
    x3 = rand * (4.0 - x4)
    x2 = rand * (4.0 - x3 - x4)
    x1 = 4.0 - x2 - x3 - x4
    e = (x4 ** 4) * (x3 ** 3) * (x2 ** 2) * x1
    if e > emax
      vec = [x1, x2, x3, x4]
      emax = e
    end
  }
  p emax
  p vec
end


# brute_force_p2
# brute_force_p3
# brute_force_p4


equispaced_solutions
