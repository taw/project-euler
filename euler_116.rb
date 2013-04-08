#!/usr/bin/env ruby1.9

def with_caching(name, arg)
  $cache ||= {}
  $cache[name] ||= {}
  $cache[name][arg] ||= yield
end

def r(x)
  with_caching('r', x){
    if x == 0
      1
    elsif x < 0
      0
    else
      r(x-1) + r(x-2)
    end
  }
end

def g(x)
  with_caching('g', x){
    if x == 0
      1
    elsif x < 0
      0
    else
      g(x-1) + g(x-3)
    end
  }
end

def b(x)
  with_caching('b', x){
    if x == 0
      1
    elsif x < 0
      0
    else
      b(x-1) + b(x-4)
    end
  }
end

def p116(x)
  r(x) + b(x) + g(x) - 3
end

p p116(5)
p p116(50)

