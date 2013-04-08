#!/usr/bin/env ruby1.9

def with_caching(name, arg)
  $cache ||= {}
  $cache[name] ||= {}
  $cache[name][arg] ||= yield
end

def u(x)
  with_caching('u', x){
    if x == 0
      1
    elsif x < 0
      0
    else
      u(x-1) + u(x-2) + u(x-3) + u(x-4)
    end
  }
end


p u(5)
p u(50)

