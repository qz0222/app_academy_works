require "byebug"
require_relative 'card'

class Board

attr_accessor :board

  CARD_VALUES = ("A".."Z").to_a

  def initialize (size)
    @board = setup(size)
  end

  def setup(size)
      grid = Array.new(size) { Array.new(size){Card.new} }
  end

  def populate(size)
    pairs = make_deck(num_pairs(size))

    i = 0
    self.board.each do |row|
      row.each do |card|
          card.value = pairs[i]
          i += 1
      end
    end
  end

  def num_pairs(size)
    size * size / 2
  end

  def make_deck(num_pairs)
    pairs = CARD_VALUES[0, num_pairs] + CARD_VALUES[0, num_pairs]
    pairs.shuffle!
  end

  def render
    board.each do |row|
      row.each do |card|
        card.display
      end
      puts ""
    end
  end

  def won?

    board.each do |row|
      row.each do |card|

        if card.reveal_status == false

          return false
        end
      end
    end
    true
  end

  def reveal(pos)
    self[pos].reveal
  end

  def [](pos)

    row = pos[0]
    col = pos[1]
    self.board[row][col]
  end

  def []=(pos, value)
    pos = row, col
    board[row][col] = value
  end

end
