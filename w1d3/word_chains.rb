class WordChainer
  require 'set'

  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = dictionary_to_set(dictionary_file_name)
    @current_words = Set.new
    @all_seen_words = Set.new
  end

  def dictionary_to_set(dictionary_file_name)
    dictionary_set = Set.new
    File.readlines(dictionary_file_name).each {|word|
      dictionary_set << word.chomp
    }
    dictionary_set
  end

  def adjacent_words(word)
    res = Set.new
    self.dictionary.each do |el|
      next unless el.length == word.length
      difference = 0
      word.length.times do |i|
        difference += 1 if el[i] != word[i]
      end
      res << el if difference == 1
    end
    res
  end

  def run(source, target)
    self.current_words << source
    self.all_seen_words << source
    until current_words.empty?
      new_current_words = Set.new
      self.current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          self.all_seen_words << adjacent_word
        end
      end
      p new_current_words
      self.current_words = new_current_words
    end
  end

end


game = WordChainer.new("dictionary.txt")
game.run('box','mop')
