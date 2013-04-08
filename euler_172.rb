#!/usr/bin/env ruby1.9

def p172_naive(limit)
  c = 0
  (10**(limit-1)..(10**limit-1)).each{|i|
    io = i
    ds = Hash.new(0)
    ok = true
    while i != 0
      d,i = i%10,i/10
      ds[d] += 1
      ok = false if ds[d] > 3
    end
    c += 1 if ok
  }
  c
end

$q={}
def q(t,d,u,z,todo)
  $q[[t,d,u,z,todo]] ||= if todo == 0
    1
  else
    e = 0
    e += d * q(t+1, d-1, u, z, todo-1) if d >= 0
    e += u * q(t, d+1, u-1, z, todo-1) if u >= 0
    e += z * q(t, d, u+1, z-1, todo-1) if z >= 0
    e
  end
end

def p172_fast(limit)
  # 10% start with leading 0 - am I smart or what :-p
  9*q(0, 0, 0, 10, limit)/10
end

#p p172_naive(6)
p p172_fast(6)

p p172_fast(18)
