#!/usr/bin/env ruby1.9

$df = (0..9).map{|i| (1..i).inject(1, &:*)}
$dfs = {}
$df.each_with_index{|v,i| $dfs[i.to_s]=v}

class Integer
  def f
    to_s.split(//).map{|x| $dfs[x]}.inject(&:+)
  end
  def s
    to_s.split(//).map(&:to_i).inject(&:+)
  end
  def sf
    f.s
  end
end

g = []

(1..1_000_000).each{|n|
  u = n.sf
  next if g[u]
  g[u] = n
}

sg = g.map{|x| x&&x.s}

p 342.f
p 342.sf
p g[20]

p g
p sg
p sg.compact.inject(&:+)
