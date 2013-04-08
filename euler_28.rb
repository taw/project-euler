#!/usr/bin/env ruby1.9

class Array
  def up(sv)
    rv = [sv]
    each{|x|
      rv << rv[-1] + x
    }
    rv
  end
  def up2(sv)
    self.up(sv).up(1)
  end
end

p ([8] * 499).up2(2).inject(&:+) + ([8] * 499).up2(4).inject(&:+) + ([8] * 499).up2(6).inject(&:+) + ([8] * 499).up2(8).inject(&:+) - 3
