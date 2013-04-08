#!/usr/bin/env ruby1.9

require "mathn"

def autohash
  Hash.new{|ht,k| ht[k] = Hash.new(&ht.default_proc)}
end

def verify_group!(*xs)
  xs.each{|x|
    xs.each{|y|
      next if x == y
      xy = "#{x}#{y}".to_i
      raise "#{xs.join(' ')} - #{xy} is not a prime" unless xy.prime?
    }
  }
end

def concatenable_prime_pairs
  ps = []
  Prime.each{|p|
    ps.each{|q|
      next unless "#{p}#{q}".to_i.prime?
      next unless "#{q}#{p}".to_i.prime?
      yield(p,q)
    }
    ps << p
  }
end

def concatenable_prime_triples
  edges = autohash
  concatenable_prime_pairs{|a,b|
    verify_group!(a,b)
    edges[a].keys.each{|c|
      yield(a,b,c) if edges[b][c] == true
    }
    edges[a][b] = true
  }
end

def concatenable_prime_quadruples
  triangles = autohash
  concatenable_prime_triples{|a,b,c|
    verify_group!(a,b,c)
    triangles[a][b].keys.each{|d|
      next unless triangles[b][d] == true
      yield(a, b, c, d)
    }
    triangles[a][b][c] = true
  }
end

qd = autohash
concatenable_prime_quadruples{|a,b,c,d|
  qd[a][b][c].keys.each{|e|
    verify_group!(a,b,c,d)
    next unless qd[a][b][d][e] == true
    verify_group!(a,b,c,d,e)
    p [a, b, c, d, e]
  }
  qd[a][b][c][d] = true
}
