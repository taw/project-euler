#!/usr/bin/env ruby1.9

class Array
  include Comparable
end

def parse_card(x)
  vs = x[0,1]
  v = case vs
  when 'T'
    10
  when 'J'
    11
  when 'Q'
    12
  when 'K'
    13
  when 'A'
    14
  when /\A\d+\Z/
    vs.to_i
  else
    raise "What is this card? #{vs}"
  end
  s = x[1,1]
  [v, s]
end

class Array
  def diffs
    (1...size).map{|i| self[i] - self[i-1]}
  end
  
  def uniq_counts
    v = Hash.new(0)
    each{|x| v[x] += 1}
    v.to_a.map{|k,v| [v,k]}.sort.reverse
  end
end

def value(cards)
  values         = cards.map{|v,s| v}
  same_suit      = cards.map{|v,s| s}.uniq.size == 1
  unique_counts  = values.uniq_counts
  sorted_uniques = unique_counts.map{|v,k| k}
  straight       = sorted_uniques.diffs == [-1,-1,-1,-1]
  return [100, :royal_flush] if same_suit and values.sort == [10,11,12,13,14] # No secondary
  return [90, *sorted_uniques, :straight_flush] if same_suit and straight
  return [80, *sorted_uniques, :four_of_kind] if unique_counts[0][0] == 4
  return [70, *sorted_uniques, :full_house] if unique_counts[0][0] == 3 and unique_counts[1][0] == 2
  return [60, *sorted_uniques, :flush] if same_suit
  return [50, *sorted_uniques, :straight] if straight
  return [40, *sorted_uniques, :three_of_kind] if unique_counts[0][0] == 3
  return [30, *sorted_uniques, :two_pairs] if unique_counts[0][0] == 2 and unique_counts[1][0] == 2
  return [20, *sorted_uniques, :one_pair] if unique_counts[0][0] == 2
  return [10, *sorted_uniques, :by_value]
end

poker = File.readlines('poker.txt').map{|x| x.chomp.split(/ /)}

minipoker = %q[5H 5C 6S 7S KD
2C 3S 8S 8D TD
5D 8C 9S JS AC
2C 5C 7D 8S QH
2D 9C AS AH AC
3D 6D 7D TD QD
4D 6S 9H QH QC
3D 6D 7H QD QS
2H 2D 4C 4D 4S
3C 3D 3S 9S 9D].split(/\n/).map{|x| x.split(/ /).map{|c| parse_card(c)}}

# minipoker.each{|cs|
#   p [cs, value(cs)]
# }

ht = Hash.new(0)
poker.each{|cards_txt|
  cards = cards_txt.map{|c| parse_card(c)}
  a, b = cards[0, 5].sort, cards[5, 5].sort
  va = value(a)
  vb = value(b)
  winner = (va == vb) ? 'draw' : (va > vb) ? 'Player 1' : 'Player 2'
  ht[winner] += 1
  p [cards_txt[0,5].join(' '), va, cards_txt[5,5].join(' '), vb, winner]
}
p ht
