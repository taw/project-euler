#!/usr/bin/env ruby1.9

require "pp"

def generate_cubes
  rv = []
  (0..9).each{|a|
    (0..9).each{|b|
      (0..9).each{|c|
        (0..9).each{|d|
          (0..9).each{|e|
            (0..9).each{|f|
              cu = [a,b,c,d,e,f].sort
              next unless cu.uniq.size == 6
              rv << cu
            }
          }
        }
      }
    }
  }
  rv
end

pairs = (1..9).map{|x| ((x**2).to_s.gsub(/9/,'6').split(//) + ['0'])[0,2].sort.map(&:to_i)}.uniq
p pairs

# 4s to generate
cubes = generate_cubes.uniq # 210 cubes

cnt = 0
cubes.each{|a|
  a += [9] if a.include?(6)
  a += [6] if a.include?(9)
  cubes.each{|b|
    b += [9] if b.include?(6)
    b += [6] if b.include?(9)
    if pairs.all?{|x,y| (a.include?(x) and b.include?(y)) or (a.include?(y) and b.include?(x))}
      cnt += 1
    end
  }
}
p(cnt/2)
