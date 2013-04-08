#!/usr/bin/env ruby1.9

coins = [2, 5, 10, 20, 50, 100, 200]

# Assume 1-coin always present, coins sorted
def combinations(value, coins)
  return [[1] * value] if coins.empty?
  extra_coins = coins[0..-2]
  last_coin = coins[-1]
  rv = []
  lcc = 0
  while value >= 0
    combinations(value, extra_coins).each{|subc|
      rv << subc + [last_coin] * lcc
    }
    value -= last_coin
    lcc += 1
  end
  return rv
end

p combinations(200, coins).size
