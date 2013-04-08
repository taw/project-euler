#!/usr/bin/env ruby1.9

def forever(&blk)
  (1..(1.0/0.0)).each(&blk)
end

def n3
  forever{|i|
    yield(i*(i+1)/2)
  }
end

def n4
  forever{|i|
    yield(i**2)
  }
end

def n5
  forever{|i|
    yield(i*(3*i-1)/2)
  }
end

def n6
  forever{|i|
    yield(i*(2*i-1))
  }
end

def n7
  forever{|i|
    yield(i*(5*i-3)/2)
  }
end

def n8
  forever{|i|
    yield(i*(3*i-2))
  }
end

def gather4(func)
  rv = []
  send(func){|i|
    next if i < 1000
    break if i >= 10000
    rv << i
  }
  rv
end

u3=gather4(:n3)
u4=gather4(:n4)
u5=gather4(:n5)
u6=gather4(:n6)
u7=gather4(:n7)
u8=gather4(:n8)

uht = {}
[u3,u4,u5,u6,u7,u8].each_with_index{|uz,j|
  j=3+j
  uz.each{|x|
    uht[x] ||= []
    uht[x] << j
  }
}

ux=(u3+u4+u5+u6+u7+u8).uniq
ux.each{|a|
  ux.each{|b|
    next unless a%100 == b/100
    ux.each{|c|
      next unless b%100 == c/100
      ux.each{|d|
        next unless c%100 == d/100
        ux.each{|e|
          next unless d%100 == e/100
          ux.each{|f|
            next unless e%100 == f/100
            next unless f%100 == a/100
            nu = [a,b,c,d,e,f].map{|x| uht[x]}
            next unless nu.flatten.uniq.size == 6
            next if (nu - [[3]]).size < 5
            next if (nu - [[4]]).size < 5
            next if (nu - [[5]]).size < 5
            next if (nu - [[6]]).size < 5
            next if (nu - [[7]]).size < 5
            next if (nu - [[8]]).size < 5
            next unless [a,b,c,d,e,f].min == a # Print just once
            p [a,b,c,d,e,f,nu]
            p [a,b,c,d,e,f].inject(&:+)
          }
        }
      }
    }
  }
}
