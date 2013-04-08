#!/usr/bin/env ruby1.9

require "pp"

class Integer
  def square?
    s = Math.sqrt(self).to_i
    s*s == self
  end
end

def minimal_solution(d)
  y = 0
  while true
    y += 1
    dyy1 = d*y*y+1
    next unless dyy1.square?
    return Math.sqrt(dyy1).to_i
  end
end

rv = []

(1..1000).each{|d|
  if d.square?
    puts "Skipping D=#{d} as a square"
    next
  end
  x = minimal_solution(d)
  puts "Minimal solution for D=#{d} is x=#{x}"
  rv << [x, d]
}

pp rv.sort

__END__

Skipping D=1 as a square
Minimal solution for D=2 is x=3
Minimal solution for D=3 is x=2
Skipping D=4 as a square
Minimal solution for D=5 is x=9
Minimal solution for D=6 is x=5
Minimal solution for D=7 is x=8
Minimal solution for D=8 is x=3
Skipping D=9 as a square
Minimal solution for D=10 is x=19
Minimal solution for D=11 is x=10
Minimal solution for D=12 is x=7
Minimal solution for D=13 is x=649
Minimal solution for D=14 is x=15
Minimal solution for D=15 is x=4
Skipping D=16 as a square
Minimal solution for D=17 is x=33
Minimal solution for D=18 is x=17
Minimal solution for D=19 is x=170
Minimal solution for D=20 is x=9
Minimal solution for D=21 is x=55
Minimal solution for D=22 is x=197
Minimal solution for D=23 is x=24
Minimal solution for D=24 is x=5
Skipping D=25 as a square
Minimal solution for D=26 is x=51
Minimal solution for D=27 is x=26
Minimal solution for D=28 is x=127
Minimal solution for D=29 is x=9801
Minimal solution for D=30 is x=11
Minimal solution for D=31 is x=1520
Minimal solution for D=32 is x=17
Minimal solution for D=33 is x=23
Minimal solution for D=34 is x=35
Minimal solution for D=35 is x=6
Skipping D=36 as a square
Minimal solution for D=37 is x=73
Minimal solution for D=38 is x=37
Minimal solution for D=39 is x=25
Minimal solution for D=40 is x=19
Minimal solution for D=41 is x=2049
Minimal solution for D=42 is x=13
Minimal solution for D=43 is x=3482
Minimal solution for D=44 is x=199
Minimal solution for D=45 is x=161
Minimal solution for D=46 is x=24335
Minimal solution for D=47 is x=48
Minimal solution for D=48 is x=7
Skipping D=49 as a square
Minimal solution for D=50 is x=99
Minimal solution for D=51 is x=50
Minimal solution for D=52 is x=649
Minimal solution for D=53 is x=66249
Minimal solution for D=54 is x=485
Minimal solution for D=55 is x=89
Minimal solution for D=56 is x=15
Minimal solution for D=57 is x=151
Minimal solution for D=58 is x=19603
Minimal solution for D=59 is x=530
Minimal solution for D=60 is x=31
Minimal solution for D=61 is x=1766319049
Minimal solution for D=62 is x=63
Minimal solution for D=63 is x=8
Skipping D=64 as a square
Minimal solution for D=65 is x=129
Minimal solution for D=66 is x=65
Minimal solution for D=67 is x=48842
Minimal solution for D=68 is x=33
Minimal solution for D=69 is x=7775
Minimal solution for D=70 is x=251
Minimal solution for D=71 is x=3480
Minimal solution for D=72 is x=17
Minimal solution for D=73 is x=2281249
Minimal solution for D=74 is x=3699
Minimal solution for D=75 is x=26
Minimal solution for D=76 is x=57799
Minimal solution for D=77 is x=351
Minimal solution for D=78 is x=53
Minimal solution for D=79 is x=80
Minimal solution for D=80 is x=9
Skipping D=81 as a square
Minimal solution for D=82 is x=163
Minimal solution for D=83 is x=82
Minimal solution for D=84 is x=55
Minimal solution for D=85 is x=285769
Minimal solution for D=86 is x=10405
Minimal solution for D=87 is x=28
Minimal solution for D=88 is x=197
Minimal solution for D=89 is x=500001
Minimal solution for D=90 is x=19
Minimal solution for D=91 is x=1574
Minimal solution for D=92 is x=1151
Minimal solution for D=93 is x=12151
Minimal solution for D=94 is x=2143295
Minimal solution for D=95 is x=39
Minimal solution for D=96 is x=49
Minimal solution for D=97 is x=62809633
Minimal solution for D=98 is x=99
Minimal solution for D=99 is x=10
Skipping D=100 as a square
Minimal solution for D=101 is x=201
Minimal solution for D=102 is x=101
Minimal solution for D=103 is x=227528
Minimal solution for D=104 is x=51
Minimal solution for D=105 is x=41
Minimal solution for D=106 is x=32080051
Minimal solution for D=107 is x=962
Minimal solution for D=108 is x=1351
.
^C./euler_66b.rb:16:in `minimal_solution': Interrupt
	from ./euler_66b.rb:29:in `block in <main>'
	from ./euler_66b.rb:24:in `each'
	from ./euler_66b.rb:24:in `<main>'


real	394m59.265s
user	392m33.309s
sys	0m56.979s
