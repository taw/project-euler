#!/usr/bin/env ruby

require "rational"

class State
  attr_reader :different_colors_chosen

  def initialize(chosen)
    @chosen = chosen
    @balls_in_urn = 70 - @chosen.sum
    @different_colors_chosen = @chosen.count{|c| c > 0}
  end

  def followup
    7.times.each do |i|
      balls_left = 10 - @chosen[i]
      next if balls_left == 0
      next_chosen = @chosen.dup
      next_chosen[i] += 1
      yield(Rational(balls_left, @balls_in_urn), next_chosen.sort)
    end
  end
end

class StateSpace
  def initialize
    @states = {}
  end

  def add(weight, state_key)
    @states[state_key] ||= 0
    @states[state_key] += weight
  end

  def iteration
    ss = StateSpace.new
    @states.each do |state_key, weight|
      state = State.new(state_key)
      state.followup do |followup_weight, followup_key|
        ss.add weight*followup_weight, followup_key
      end
    end
    ss
  end

  def expected_colors
    e = 0
    @states.each do |state_key, weight|
      state = State.new(state_key)
      e += weight * state.different_colors_chosen
    end
    e
  end
end

ss = StateSpace.new
ss.add 1, [0, 0, 0, 0, 0, 0, 0]

20.times do
  ss = ss.iteration
end

pp ss.expected_colors.to_f.round(9)
