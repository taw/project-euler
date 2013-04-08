#!/usr/bin/env ruby1.9

class SeqEnumExplicit
  attr_accessor :data
  
  def initialize(data)
    @data = data
  end
  
  def prefix(x)
    self.class.new(@data.map{|y| [x]+y})
  end
  
  def +(other)
    self.class.new(data + other.data)
  end
  
  def inc0(v)
    self.class.new(@data.map{|y| yd = y.dup; yd[0]+=v; yd})
  end
  
  def to_s
    "#{data.size} - #{data.map(&:inspect).join(' ')}"
  end
end

class SeqEnumFast
  attr_accessor :data
    
  def initialize(data)
    @data = data.is_a?(Array) ? data.size : data
  end
  
  def prefix(x)
    self
  end
  
  def +(other)
    self.class.new(data + other.data)
  end
  
  def inc0(v)
    self
  end
  
  def to_s
    data.to_s
  end
end

SeqEnum = SeqEnumFast

class Array
  def first_plus(x)
    n = dup
    n[0] += x
    n
  end
  
  $memo = {}
  def p169
    return $memo[self] if $memo[self]
    
    rest = self[1..-1]
    rv = if empty?
      SeqEnum.new([[]]) # 1
    elsif size == 1
      if self[0] <= 2
        SeqEnum.new([[self[0]]])
      else
        SeqEnum.new([])
      end
    elsif self[0] == 0
      rest.p169.prefix(0)
    elsif self[0] == 1
      with_1 = rest.p169.prefix(1)
      with_0 = rest.first_plus(2).p169.prefix(0)
      with_0 + with_1
    elsif self[0] == 2
      with_2 = rest.p169.prefix(2)
      with_1 = rest.first_plus(2).p169.prefix(1)
      with_1 + with_2
    elsif self[0] == 3
      rest.first_plus(2).p169.prefix(2)
    else
      raise "WTF? #{self}"
    end
    #puts "P[#{self.join(' ')}] = #{rv}"
    
    $memo[self] = rv
    rv
  end
end

def p169(x)
  bits = x.to_s(2).split(//).map(&:to_i)
  #p bits
  bits.p169
end

(1..25).each{|x|
  puts "#{x} -> #{p169(10**x)}"
}
# p p169(10**25)
