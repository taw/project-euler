#!/usr/bin/env ruby

require "pp"

# D0 = Fa
# "a" → "aRbFR"
# "b" → "LFaLb"

class String
  def next_dragon
    gsub(/a|b/){ $& == "a" ? "aRbFR" : "LFaLb"}
  end
end

def eval_dragon(dragon, state)
  state = state.dup
  dragon.each_char{|c|
    break if state[4] == 0
    case c
    when "a", "b"
      next
    when "F"
      state[0] += state[2]
      state[1] += state[3]
      state[4] -= 1
    when "R"
      state[2], state[3] = state[3], -state[2]
    when "L"
      state[2], state[3] = -state[3], state[2]
    end
  }
  state
end

def p220_naive
  d0 = 'Fa'
  d1 = d0.next_dragon
  d2 = d1.next_dragon
  d3 = d2.next_dragon
  d4 = d3.next_dragon
  d5 = d4.next_dragon
  d6 = d5.next_dragon
  d7 = d6.next_dragon
  d8 = d7.next_dragon
  d9 = d8.next_dragon
  d10 = d9.next_dragon
  
  state = [0, 0, 0, 1, 500]
  p eval_dragon(d10, state)
end  

def eval_f(state)
  return state unless state[4] > 0
  [state[0] + state[2], state[1] + state[3], state[2], state[3], state[4] - 1]
end

def eval_r(state)
  [state[0], state[1], state[3], -state[2], state[4]]
end

def eval_l(state)
  [state[0], state[1], -state[3], state[2], state[4]]
end

def eval_a(i, state)
  return state if i == 0
  state = eval_a(i-1, state)
  state = eval_r(state)
  state = eval_b(i-1, state)
  state = eval_f(state)
  state = eval_r(state)
end

def eval_b(i, state)
  return state if i == 0
  state = eval_l(state)
  state = eval_f(state)
  state = eval_a(i-1, state)
  state = eval_l(state)
  state = eval_b(i-1, state)
end

def eval_d(i, state)
  state = eval_f(state)
  state = eval_a(i, state)
end

pp eval_d(10, [0, 0, 0, 1, 500])
