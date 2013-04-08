#!/usr/bin/env ruby1.9

# Cycle detector solution - FAIL

def lagfib_step!(state, m)
  state << (state[0] + state[1]) % m
  state.shift
end

def forever(&blk)
  (0..(1.0/0.0)).each(&blk)
end

# gk = 1 for 0<=k<=1999
def lagfibmod(lag, m)
  s1 = [1] * lag
  s2 = [1] * lag
  forever{|i|
    lagfib_step!(s1, m)
    lagfib_step!(s2, m)
    lagfib_step!(s2, m)
    if s1 == s2
      p (i+1)
      p s1
      break
    end
  }
end

lagfibmod(3, 1_000_001)
