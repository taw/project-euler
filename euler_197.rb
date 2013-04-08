#!/usr/bin/env ruby1.9

def each_u
  ui, i = -1, 0
  while true
    yield(ui, i)
    ui = (2 ** (30.403243784 - ui**2)).floor * (10 ** -9)
    i += 1
  end
end

each_u{|ui,i|
  p [ui.to_f, i]
  break if i == 10000
}
