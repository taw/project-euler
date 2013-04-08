#!/usr/bin/env ruby1.9

raise 'SLOW as fuck and answer=1960200 is fail'

require "mathn"

class Integer
  def powmod(x, m)
    # Very slow version
    (self**x) % m
  end
end

class Zn
  def initialize(prime)
    @prime = prime
    @memo = {}
  end
  
  def exp_same?(n, exponent)
    @memo[[n, exponent]] ||= (n.powmod(exponent, @prime) == n)
  end
end

class RSA
  # RSA's p is called r so it doesn't collide with Kernel#p
  attr_reader :r, :q, :phi, :n
  
  def initialize(r,q)
    @r=r
    @q=q
    @phi = (r-1) * (q-1)
    @n = r*q
  end

  # For (1009, 3643) there are 1047167 values
  def each_e
    (2...@phi).each{|e|
      next unless @phi.gcd(e) == 1
      yield(e)
    }
  end

  def unconcealed_messages_v0(e)
    count = 0
    (0...@n).each{|m|
      c = m.powmod(e, n)
      count += 1 if c == m
    }
    count
  end

  def unconcealed_messages_v1(e)
    count = 0
    # By Chinese remainder theorem
    (0...@r).each{|i|
      (0...@q).each{|j|
        ci = i.powmod(e, @r)
        cj = j.powmod(e, @q)
        count += 1 if ci == i and cj == j
      }
    }
    count
  end

  def unconcealed_messages_v2(e)
    count = 0
    # By Chinese remainder theorem
    zr = Zn.new(@r)
    zq = Zn.new(@q)
    (0...@r).each{|ri|
      (0...@q).each{|qi|
        count += 1 if zr.exp_same?(ri, e) and zq.exp_same?(qi, e)
      }
    }
    count
  end

  def unconcealed_messages_v3(e)
    # By Chinese remainder theorem
    zr = Zn.new(@r)
    zq = Zn.new(@q)
    cr, cq = 0, 0
    (0...@r).each{|ri|
      cr += 1 if zr.exp_same?(ri, e)
    }
    (0...@q).each{|qi|
      cq += 1 if zq.exp_same?(qi, e)
    }
    cr*cq
  end

  def unconcealed_messages_v4(e)
    # By Chinese remainder theorem
    qc, rc = 0, 0
    re, qe = e % (@r-1), e % (@q-1)
    zr, zq = Zn.new(@r), Zn.new(@q)
    (0...@r).each{|ri|
      rc += 1 if zr.exp_same?(ri, re)
    }
    (0...@q).each{|qi|
      qc += 1 if zq.exp_same?(qi, qe)
    }
    rc*qc
  end

  def count_same(prime, exponent)
    @count_same_memo ||= {}
    unless @count_same_memo[[prime, exponent]]
      puts "CS cache miss #{prime} #{exponent}"
      z_prime = Zn.new(prime)
      c = 0
      (0...prime).each{|i|
        c += 1 if z_prime.exp_same?(i, exponent)
      }
      @count_same_memo[[prime, exponent]] = c
    end
    @count_same_memo[[prime, exponent]]
  end

  def unconcealed_messages_v5(e)
    count_same(@q, e % (@q-1)) * count_same(@r, e % (@r-1))
  end
  
  def self.small
    new(19, 37)
  end
  
  def self.big
    new(1009, 3643)
  end
end

def um_test!
  rsa = RSA.small
  rsa.each_e{|e|
    a = rsa.unconcealed_messages_v4(e)
    b = rsa.unconcealed_messages_v5(e)
    if a != b
      raise "#{e} #{a} #{b} FAIL"
    end
  }
end

def benchmark!(bm)
  t0 = Time.now
  yield
  t1 = Time.now
  puts "#{bm} - #{t1-t0}s"
end

def um_benchmark!
  rsa = RSA.small
  benchmark!('v4'){
    rsa.each_e{|e| rsa.unconcealed_messages_v4(e)}
  }
  benchmark!('v5'){
    rsa.each_e{|e| rsa.unconcealed_messages_v5(e)}
  }
  benchmark!('v-inf'){
    rsa.each_e{|e|}
  }
end

# um_test!
# um_benchmark!

# 100 entries -> 22s
# 1m entries  -> 66h
# Huh? Still slow as fuck

best_val = 1.0/0.0
best_es = []
rsa = RSA.big

x=0
t0=Time.now

# Oh, actually it should speed up as it goes, as first it will cache miss like crazy, then
# it will mostly cache hit
rsa.each_e{|e|
  x+=1
  if x % 1000 == 0
    t1=Time.now
    eta = (t1-t0) * 1047167 / x
    puts "Speed #{x} -> #{t1-t0} / ETA #{eta}"
  end
  puts "Testing #{e}"
  r = rsa.unconcealed_messages_v5(e)
  next unless r <= best_val
  if r < best_val
    best_val = r
    best_es = []
  end
  best_es << r
  p [e, r]
}
p best_val
p best_es
p best_es.inject(&:+)
