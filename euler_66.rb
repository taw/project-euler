#!/usr/bin/env ruby1.9

raise 'FAIL'

#require "mathn"

class Integer
  def square?
    raise "This method is pile of fail for big integers"
    s = Math.sqrt(self)
    s.floor == s
  end
end

def self_test
  p 15.square?
  p 255.square?
  p 16.square?
  p 0.square?
  p 256.square?
end

def dioph_solution?(x, d)
  # x*x - d*y*y = 1
  # x*x - 1 = d*y*y
  a = (x*x-1)
  return false unless a % d == 0
  (a/d).square?
end

# def find_dioph(d, max_x=1000)
#   puts "Testing #{d}"
#   return nil if d.square?
#   (2..max_x).each{|x|
#     return x if dioph_solution?(x, d)
#   }
#   puts "No dioph for #{d}"
#   return nil
# end
# 
# 
# 
# p (1..1000).p{|d| find_dioph(d, 1000_000_000)}.compact.max

solved_ds = {}
unsolved_ds = {}
(1..1000).each{|d| unsolved_ds[d] = true unless d.square?}

begin
  (2..1_000_000_000_000).each{|x|
    puts "Trying #{x} / #{unsolved_ds.keys.size}" if x % 10_000 == 0
    unsolved_ds.keys.each{|d|
      if dioph_solution?(x, d)
        puts "Found #{d} - #{x}"
        solved_ds[d] = x
        unsolved_ds.delete(d)
      end
    }
  }
rescue Exception
  puts "Printing partial results:"
  max_x_2 = solved_ds.values.max / 2
  solved_ds.to_a.sort.each{|d,x|
    puts "#{d} -> #{x}" if x > max_x_2
  }
  p unsolved_ds.keys.size
  p unsolved_ds.keys
end

__END__

Printing partial results:
106 -> 32080051
172 -> 24248647
202 -> 19731763
284 -> 24220799
311 -> 16883880
365 -> 23915529
415 -> 18412804
424 -> 32080051
550 -> 30580901
639 -> 24220799
666 -> 27365201
688 -> 24248647
722 -> 22619537
808 -> 19731763
954 -> 32080051
250
[61, 97, 109, 139, 149, 151, 157, 163, 166, 181, 193, 199, 211, 214, 233, 241, 244, 250, 253, 261, 262, 265, 268, 271, 277, 281, 283, 298, 301, 307, 309, 313, 317, 331, 334, 337, 343, 349, 353, 358, 367, 373, 379, 382, 388, 393, 394, 397, 406, 409, 412, 417, 419, 421, 431, 433, 436, 445, 446, 449, 451, 454, 457, 461, 463, 466, 477, 478, 481, 487, 489, 491, 493, 501, 502, 508, 509, 511, 517, 521, 523, 524, 526, 533, 537, 538, 541, 547, 549, 553, 554, 556, 559, 562, 565, 566, 569, 571, 581, 586, 589, 593, 596, 597, 599, 601, 604, 606, 607, 610, 613, 614, 617, 619, 622, 628, 629, 631, 633, 634, 637, 641, 643, 647, 649, 652, 653, 655, 661, 662, 664, 667, 669, 673, 679, 681, 683, 685, 686, 691, 694, 698, 701, 709, 716, 718, 719, 721, 724, 733, 737, 739, 742, 746, 749, 751, 753, 754, 757, 758, 763, 764, 766, 769, 771, 772, 773, 778, 781, 787, 789, 790, 794, 796, 797, 801, 802, 805, 807, 809, 811, 814, 821, 823, 826, 829, 834, 835, 838, 844, 845, 849, 853, 856, 857, 859, 861, 862, 863, 865, 869, 871, 873, 877, 879, 881, 883, 886, 889, 893, 907, 911, 913, 914, 917, 919, 921, 922, 926, 928, 929, 931, 932, 937, 941, 946, 947, 949, 951, 953, 955, 956, 958, 964, 965, 967, 970, 971, 972, 974, 976, 977, 981, 988, 989, 991, 997, 998, 999, 1000]
