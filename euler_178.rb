#!/usr/bin/env ruby1.9

$q={}
def q(last, s0, s9, todo)
  $q[[last,s0,s9,todo]] ||= if todo == 0
    (s0 and s9) ? 1 : 0
  else
    if last == 0
      q(last+1, s0, s9, todo-1)
    elsif last == 1
      q(last+1, s0, s9, todo-1) +
      q(last-1, true, s9, todo-1)
    elsif last == 8
      q(last+1, s0, true, todo-1) +
      q(last-1, s0, s9, todo-1)
    elsif last == 9
      q(last-1, s0, s9, todo-1)
    else
      q(last+1, s0, s9, todo-1) +
      q(last-1, s0, s9, todo-1)
    end
  end
end

def p178(limit)
  (1..9).map{|i|
    q(i, false, i==9, limit-1)
  }.inject(0, &:+)
end


p p178(9)
p p178(10)
p p178(11)
p p178(12)
p (1..40).map{|i| p178(i)}.inject(0, &:+)

# 64203722859 appears to be incorrect :-(
