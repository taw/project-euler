#!/usr/bin/env ruby1.9

class InvalidSudoku < Exception
end

class Sudoku
  def initialize(rows)
    @rows = rows
  end
  
  def to_s
    @rows.map{|row| row.map{|c| c.nil? ? '.' : c.to_s }.join + "\n"}.join
  end

  def options
    (0..8).each{|i|
      (0..8).each{|j|
        next if @rows[i][j]
        conflicts = []
        (0..8).each{|k|
          conflicts << @rows[i][k]
          conflicts << @rows[k][j]
        }
        iz = (i / 3) * 3
        jz = (j / 3) * 3
        (0..2).each{|is|
          (0..2).each{|js|
            conflicts << @rows[iz+is][jz+js]
          }
        }
        options = (1..9).to_a - conflicts.compact
        if options.empty?
          raise InvalidSudoku.new
        end
        yield(i, j, options)
      }
    }
  end

  def propagate_once!
    options{|i,j,options|
      if options.size == 1
        @rows[i][j] = options[0]
        return true
      end
    }
    return false
  end
  
  def propagate!
    true while propagate_once!
  end
  
  def solved?
    options{ return false }
    return true
  end
  
  def valid?
    options{}
  end
  
  def solve!(level=0)
    propagate!
    options{|i,j,opts|
      #p [i,j,opts]
      opts.each{|k|
        begin
          #puts "Trying #{level}: #{i}:#{j} -> #{k}"
          s = try_number(i,j,k)
          return s.solve!(level+1)
        rescue InvalidSudoku
        end
      }
      raise InvalidSudoku
    }
    return self
  end

  def try_number(i0,j0,k)
    new_rows = (0..8).map{|i|
      (0..8).map{|j|
        (i==i0 and j==j0) ? k : @rows[i][j]
      }
    }
    Sudoku.new(new_rows)
  end
  
  def score
    81 - @rows.map{|row| row.count(&:nil?)}.inject(&:+)
  end
  
  def top3
    @rows[0][0,3].join.to_i
  end
end

score = 0
top3 = 0

lines = File.readlines('sudoku.txt').map(&:chomp)
while !lines.empty?
  name = lines[0]
  #puts name
  sudoku = Sudoku.new(lines[1,9].map{|line| line.split(//).map(&:to_i).map{|x| x==0 ? nil : x}})
  10.times{lines.shift}

  sudoku = sudoku.solve!
  #sudoku.propagate!

  score += sudoku.score
  top3 += sudoku.top3
  puts sudoku
  puts ""
end

puts "Total score: #{score} [1418 -> 4050]"
puts "Top3: #{top3}"
