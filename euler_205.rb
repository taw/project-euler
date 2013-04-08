#!/usr/bin/env ruby1.9

class Distribution
  attr_reader :data
  
  def initialize(data)
    @data = data
  end

  def zip(other)
    ab = Hash.new(0)
    data.each{|a,ai|
      other.data.each{|b,bi|
        ab[[a,b]] += ai*bi
      }
    }
    self.class.new(ab.to_a.sort)
  end

  def map
    ax = Hash.new(0)
    data.each{|a,ai|
      ax[yield(a)] += ai
    }
    self.class.new(ax.to_a.sort)
  end
  
  def +(other)
    zip(other).map{|a,b|a+b}
  end

  def -(other)
    zip(other).map{|a,b|a-b}
  end
  
  def to_s
    "<" + @data.map{|a,ai| "#{a}:#{ai}"}.join(" ") + ">"
  end

  class <<self
    def die(k)
      new((1..k).map{|x| [x,1]})
    end
  end
  
  def [](v)
    @data.find{|a,ai| a==v}[1]
  end
end

def k(n)
  Distribution.die(n)
end

dist_9k4 = (1..9).map{ k(4) }.inject(&:+)
dist_6k6 = (1..6).map{ k(6) }.inject(&:+)

dist_diff = dist_9k4 - dist_6k6
dist_res = dist_diff.map{|a| a>0 ? 'win' : 'lose'}
p dist_res
w = dist_res['win']
l = dist_res['lose']

p (1_000_000_000 * w / (w+l))
