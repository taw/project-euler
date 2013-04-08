#!/usr/bin/env ruby1.9

require "pp"

class Game
  attr_reader :states, :ignored, :accepted, :goal, :done
  
  def initialize(ignored, accepted, goal)
    @ignored = ignored
    @accepted = accepted
    @goal = goal
    @done = 0
    @states = {[[1.0/0.0] * ignored, 0] => 1}
  end
  
  def add!(k)
    ns = Hash.new(0)
    todo = ignored + accepted - done
    
    states.each{|(is,e), c|
      (1..k).each{|i|
        isx = [i,*is].sort[0..-2]
        ex = e+i
        est = ex - isx.inject(0, &:+)
        if est  > goal
          ex = 1.0/0.0
          isx = []
        end
        if est.is_a?(Integer) and est + k * todo < goal
          ex = -1.0/0.0
          isx = []
        end
        if todo < isx.size
          ex -= isx.shift
        end
        ns[[isx,ex]] += c
      }
    }
    @done += 1
    @states = ns
  end
  
  def collapsed_state
    cs = Hash.new(0)
    states.each{|(is,e), c|
      cs[e-is.inject(0, &:+)] += c
    }
    cs
  end
  
  def run!(k)
    (ignored+accepted).times{add!(k)}
  end
end

def run_game!
  # g = Game.new(2, 3, 15)
  # g.run!(6)
  # pp g.collapsed_state

  # g = Game.new(4, 10, 70)
  # g.run!(12)
  # pp g.collapsed_state

  # 10/3 -> 25s
  # 10/3 -> 9.8s
  # 10/4 -> 49s
  # 70=>26984849530087
end

$c = {}
def combinations(k, n)
  $c[[k,n]] ||= if n == 0
    1
  elsif k == 1
    1
  else
    (0..n).map{|i| combinations(k-1, i)}.inject(&:+)
  end
end

# p combinations(12, 20)

each_combination(6, 5){|dice, c|

}
