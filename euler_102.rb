#!/usr/bin/env ruby1.9

class Vector
  attr_reader :x, :y
  def initialize(x,y)
    @x, @y = x, y
  end
  
  def -(v)
    Vector.new(x-v.x, y-v.y)
  end

  def +(v)
    Vector.new(x+v.x, y+v.y)
  end
  
  def to_s
    "<#{x}, #{y}>"
  end

  def *(v)
    (x*v.x + y*v.y)
  end
  
  def perp
    Vector.new(-y, x)
  end
  
  def inspect
    to_s
  end
end

class Integer
  def sgn
    return 0 if self == 0
    return 1 if self > 0
    return -1
  end
end

def right_side?(a,b,c,origin)
  ca = c - a
  oa = origin - a
  ba = b - a
  pba = ba.perp
  raise "Not perpendicular" unless pba * ba == 0
  u = oa * pba
  v = ca * pba
  
#  p [ca, oa, ba, pba, u, v]
  
  if v.sgn == 0
    raise "It's not a triangle silly! #{a} #{b} #{c}"
  end
  return false if u.sgn * v.sgn == -1
  return true # Same or u == 0
end


def v(x,y)
  Vector.new(x,y)
end

def triangle_contains_origin?(a,b,c)
  origin = Vector.new(0, 0)
  right_side?(a, b, c, origin) and right_side?(b, c, a, origin) and right_side?(c, a, b, origin)
end

# p right_side?(v(0,0), v(0,1), v(1,0), v( 1, 1))
# p right_side?(v(0,0), v(0,1), v(1,0), v( 0, 1))
# p right_side?(v(0,0), v(0,1), v(1,0), v(-1, 1))
# p right_side?(v(0,0), v(0,1), v(1,0), v( 1, 0))
# p right_side?(v(0,0), v(0,1), v(1,0), v( 0, 0))
# p right_side?(v(0,0), v(0,1), v(1,0), v(-1, 0))
# p right_side?(v(0,0), v(0,1), v(1,0), v( 1, -1))
# p right_side?(v(0,0), v(0,1), v(1,0), v( 0, -1))
# p right_side?(v(0,0), v(0,1), v(1,0), v(-1, -1))
# 
# exit

triangles = File.readlines('triangles.txt').map{|line| line.chomp.split(/,/).map(&:to_i)}

e = 0
triangles.each{|ax, ay, bx, by, cx, cy|
  a = Vector.new(ax, ay)
  b = Vector.new(bx, by)
  c = Vector.new(cx, cy)

  e+=1 if triangle_contains_origin?(a,b,c)
  #   p [a, b, c, 'yes']
  # else
  #   p [a, b, c, 'no']
  # end
}
p e
