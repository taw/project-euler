#!/usr/bin/env ruby1.9

$x={}
def p191(days, late_ok=1, recently_absent=0)
  $x[[days,late_ok,recently_absent]] ||= if days == 0
    1
  else
    e  = p191(days-1, late_ok, 0)
    e += p191(days-1, late_ok-1, 0) if late_ok > 0
    e += p191(days-1, late_ok, recently_absent+1) if recently_absent < 2
    e
  end
end

p p191(4) # == 43
p p191(30)
