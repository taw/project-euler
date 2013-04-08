#!/usr/bin/env ruby1.9

class USEnglishTranslator
    # Formal, US English. Optional 'and'. Will not produce things
    # such as 'twelve hundred' but rather 'one thousand two hundred'.
    # The use of 'and' is incomplete; it is sometimes missed.

    DIGITS = %w(zero one two three four five six seven eight nine)
    TEENS  = %w(ten eleven twelve thirteen fourteen fifteen sixteen
                seventeen eighteen nineteen)
    TENS   = %w(hello world twenty thirty forty fifty sixty seventy
                eighty ninety)
    GROUPS = %w(thousand million billion trillion quadrillion
                quintillion sextillion septillion octillion nonillion
                decillion)
    K = 1000

    def initialize(conjunction = true)
        @conjunction = conjunction
    end

    def to_spoken(val)
        case val <=> 0
        when -1
            'negative ' + to_spoken(-val)
        when 0
            DIGITS[0]
        else
            group(val, 0).flatten.join(' ')
        end
    end

    private

    def group(val, level)
        x = group(val / K, level + 1) << GROUPS[level] if val >= K
        x.to_a << under_1000(val % K, level)
    end

    def under_1000(val, level)
        x = [DIGITS[val / 100]] << 'hundred' if val >= 100
        x.to_a << under_100(val % 100, (level == 0 and not x.nil?))
    end

    def under_100(val, junction)
        x = [('and' if @conjunction and junction)]    # wyf?
        case val
        when 0
            []
        when 1...10
            x << DIGITS[val]
        when 10...20
            x << TEENS[val - 10]
        else
            d = val % 10
            x << (TENS[val / 10] + ('-' + DIGITS[d] if d != 0).to_s)
        end
    end
end


class Integer
    def to_spoken(translator = USEnglishTranslator.new)
        translator.to_spoken(self).squeeze(' ').strip
    end
end

class Integer
  def as_british_word
    small = %w[zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty]
    tens = %w[zero ten twenty thirty forty fifty sixty seventy eighty ninety]
    return 'one thousand' if self == 1000
    rv = []
    if self >= 100
      rv << small[self/100] + ' hundred '
      rv << 'and ' if (self%100) != 0
      v = self%100
    else
      v = self
    end
    if v >= 20
      rv << tens[v/10] + ' '
      v %= 10
    end
    if v != 0
      rv << small[v]
    end
    rv.join(" ").gsub(/\s+/, ' ').sub(/\s*\Z/, '')
  end
  def british_word_size
    as_british_word.gsub(/ /, '').size
  end
end

(1..1000).each{|i|
  ai, bi = i.as_british_word, i.to_spoken.gsub(/-/, ' ')
  p [i, ai, bi, ai==bi]
}


# p [1, 11, 342, 115, 600, 1000, 690, 50].map(&:as_british_word)
p (1..1000).map(&:british_word_size).inject(&:+)
# p (1..5).map(&:british_word_size).inject(&:+)
# [115, 342].each{|x|
# #  x = rand(1000) + 1
#   p [x, x.as_british_word, x.british_word_size]
# }
# 
# 
# # FAIL
