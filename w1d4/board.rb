require_relative 'square'
require 'byebug'

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(9) do
      Array.new(9) { Square.new }
    end
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    board.each_with_index do |row, idx|
      puts "#{idx} #{print_row(row).join(" ")}"
    end
  end

  def find_neighbor(pos)
    result = []
    row, col = pos

    i = row - 1
    while i <=  row + 1
      if i < 0 || i > 8
        i += 1
        next
      end
      j = col - 1
      while j <= col + 1
        if j < 0 || j > 8 || (i == row && j == col)
          j += 1
          next
        end
        result << [i,j]
        j += 1
      end
      i += 1
    end
    result
  end

  def print_row(row)
    row_arr = []
    row.each do |square|
      if square.flag
        row_arr << "F"
        next
      elsif square.flip
        row_arr << square.state
        next
      else
        row_arr << " "
      end
    end
    row_arr
  end

  def [](pos)
    row, col = pos
    board[row][col]
  end

  def populate_bomb(bombs)
    bomb_location = []

    until bomb_location.length == bombs
      row = rand(9)
      col = rand(9)
      bomb_location << [row, col] unless bomb_location.include?([row, col])
      board[row][col].state = "X"
    end
    bomb_location.each do |pos|
      find_neighbor(pos).each do |neighbor|
        row, col = neighbor
        current_state = board[row][col].state
        next if current_state == "X"

        board[row][col].state = (current_state.to_i + 1).to_s
      end
    end
  end
end
