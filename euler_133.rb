#!/usr/bin/env ruby1.9

def repunit_10n_v0(m,k)
  rv = []
  (0..k).each{|i|
    rv << ("1" * (10**i)).to_i % m
  }
  rv
end

def find_mu_v0(i, m)
  digits = 10**(i-1)
  (10 ** digits) % m
end

def find_mu_v1(i, m)
  
end

def repunit_10n_v1(m,k)
  rv = [1 % m]
  (1..k).each{|i|
    xn  = rv[-1]
    xn1 = xn
    digits = (10**(i-1))
    mu = (10**digits) % m
    9.times{
      xn1 = (xn1 * mu + xn) % m
    }
    rv << xn1
  }
  rv
end


[7, 11, 17, 29, 60, 100].each{|m|
  p (1..6).map{|i| find_mu_v0(i, m)}
  p (1..6).map{|i| find_mu_v1(i, m)}
}

__END__


[3, 7, 101, 1504, 785734857, 10**1000].each{|m|
  a = repunit_10n_v1(m, 6)
  # b = repunit_10n_v1(m, 4)
  # p a
  # p b
  # p a == b
}


# v1: 6 -> 1s
