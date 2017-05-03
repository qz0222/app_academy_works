
class HumanPlayer
attr_accessor :name, :guessed_pos, :size, :revealed_pos, :value_hash

  def initialize(name)
    @name = name
    @guessed_pos = []
    @size = 0
    @revealed_pos = []
    @value_hash = {}
  end


  def take_position
    puts "Please enter a card position to flip. e.g., [1, 2] "
    position = gets.chomp.split(", ")
    position.map! { |x| x.to_i }
    until valid_move?(position)
      puts "Please enter a card position to flip. e.g., [1, 2] "
      position = gets.chomp.split(", ")
      position.map! { |x| x.to_i }
    end
    position
  end

  def valid_move?(position)

    unless position.is_a?(Array) && position.length == 2 && self.revealed_pos.include?(position)==false
      puts "position invalid"
      return false
    end
    position.each do |num|
      unless num.is_a?(Integer) && num < size
        puts "position invalid"
        return false
      end
    end
    return false if self.guessed_pos == position
    true
  end

end
