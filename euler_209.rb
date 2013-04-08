#!/usr/bin/env ruby1.9

def bits(&blk)
  (0..1).each(&blk)
end

class TwoSatGraph
  def initialize
    @components = []
  end
  
  def add_component(a,b)
    @components.each{|xs|
      if xs[-1] == a
        xs << b
        return
      elsif xs[-1] == b
        xs << a
        return
      elsif xs[0] == a
        xs.unshift(b)
        return
      elsif xs[0] == b
        xs.unshift(a)
        return
      end
    }
    @components << [a, b]
  end
  
  def rename(x)
    x =~ /\At([01]+)\Z/ or raise "Wrong name: #{x}"
    x = $1.to_i(2)
    "t#{x}"
  end
  
  def connect(a,b)
    a = rename(a)
    b = rename(b)
    
    a, b = *[a,b].sort
    if a == b
      add_component a, a
    else
      add_component a, b
    end
    #puts "#{a} @@@ #{b}"
  end

  def optimize!
    @components.each{|c|
      if c[0] > c[-1]
        c.reverse!
      end
    }
    @components.sort!
    cs = []
    while !@components.empty?
      c0 = @components.shift
      c1 = @components[0]
      if c1 != nil and c0[0] == c1[0]
        cs << c0.reverse[0..-2] + c1
        @components.shift
      else
        cs << c0
      end
    end
    @components = cs
  end

  def print!
    6.times{optimize!}
    ring_sizes = []
    @components.each{|xs|
      if xs[0] == xs[-1]
        ring_sizes << (xs.size-1)
        puts "< " + xs.join(" -- ") + " >(#{xs.size})"
      else
        puts xs.join(" -- ")
      end
    }
    puts "Ring sizes: #{ring_sizes.sort.join(' ')}"
  end
end

def find_ring_sizes!
  z = TwoSatGraph.new

  bits{|a|
    bits{|b|
      bits{|c|
        bits{|d|
          bits{|e|
            bits{|f|
              z.connect("t#{a}#{b}#{c}#{d}#{e}#{f}", "t#{b}#{c}#{d}#{e}#{f}#{a^(b&c)}")
            }
          }
        }
      }
    }
  }

  z.print!
end

$z={}
def z(looped, prev, todo)
  $z[[looped, prev, todo]] ||= if todo == 0
    if looped&prev == 1
      0
    else
      1
    end
  else
    if prev == 1
      z(looped, 0, todo-1)
    else
      z(looped, 0, todo-1) + z(looped, 1, todo-1)
    end
  end
end

def solve_ring_size(x)
  z(0, 0, x-1) + z(1, 1, x-1)
end

def solve_ring_sizes!(*numbers)
  numbers.map{|x| solve_ring_size(x)}.inject(1, &:*)
end

find_ring_sizes!

p solve_ring_sizes!(2, 3, 6, 6, 46)

# (2..10).each{|i|
#   p [i, solve_ring_size(i)]
# }

# raise "My awesome answer 156449117922692 appears to be incorrect"
