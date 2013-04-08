#!/usr/bin/env ruby1.9

class Integer
  def bouncy?
    to_s !~ /\A(?:1*2*3*4*5*6*7*8*9*|9*8*7*6*5*4*3*2*1*0*)\Z/
  end
end

# p 134468.bouncy?
# p 66420.bouncy?
# p 155349.bouncy?

i = 1
b = 0
while true
  b+=1 if i.bouncy?
  if 100*b >= 99*i
    p [i, b]
    break
  end  
  i+=1
end
