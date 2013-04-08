#!/usr/bin/env ruby1.9

class IVector
  def initialize(data)
    @data = data
  end
end

class IMatrix
  def initialize(data)
    @data = data
  end
  
  def *(other)
    if other.is_a?(IVector)
      
    elsif other.is_a?(IMatrix)
      
    else
      raise "How do I multiply by #{other.class}?"
    end
  end
end

a = IVector.new([1,100])
b = IMatrix.new([[1, 1], [1, 0]])
