#!/usr/bin/env ruby1.9

#raise "answer is 0.464399 but it appears to be incorrect :-("

require "mathn"

def transitions_to_i(env)
  pieces = env.inject(&:+)
  (0..4).map{|i|
    [env[i] / pieces, i]
  }.select{|p,i| p != 0}
end

def transitions_to_env(env)
  transitions_to_i(env).map{|p,i|
    e = env.dup
    e[i] -= 1
    (i+1..4).each{|j|
      e[j] += 1
    }
    [p, e]
  }
end

env0 = [1, 0, 0, 0, 0]

envs = {env0 => 1}
p_one = [0] * 16
16.times{|i|
  envs_new = Hash.new(0)
  envs.each{|e, p|
    p_one[i] += p if e.inject(&:+) == 1
    transitions_to_env(e).each{|new_p, new_e|
      envs_new[new_e] += new_p*p
    } 
  }
  envs = envs_new
  p envs
}
p p_one
p p_one.inject(&:+) - 2
p (p_one.inject(&:+) - 2).to_f
