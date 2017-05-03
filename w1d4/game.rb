require_relative 'board'

class Game
  attr_accessor :board

  def initialize(bombs = 1)
    @board = Board.new
    @bombs = bombs
    board.populate_bomb(bombs)
  end

  def get_position
    puts "Please provide [row,col]"
    position = gets.chomp

    translate_pos(position)
  end

  def user_flag?
    puts "Do you want to flag/unflag? Y/N"
    flagged = gets.chomp.upcase
  end

  def run
    until game_over?
     play_round
    end
    puts "Congratulations! You Win"
  end

  def flip(pos)
    return if board[pos].flip
    if square_state(pos) != "0"
      flip_square(pos)
    else
      flip_square(pos)
      board.find_neighbor(pos).each do |n_pos|
        flip(n_pos)
      end
    end
  end

  def game_over?
    @board.board.flatten.each do |square|
      if square.state != "X" && square.flip == false
        return false
      end
    end
    true
  end

  def play_round
    system('clear')
    board.render

    flagged = user_flag?
    position = get_position

    if flagged == "Y"
      change_flag(flagged, position)
    else
      if lose?(position)
        puts "You lose!"
      else
        flip(position)
      end
    end
  end

  def valid_move?(pos)
    return false if board[pos].flip
    return false if square_flag(pos)

  end


  private
  def lose?(pos)
    !square_flag(pos) && square_state(pos) == "X"
  end

  def square_state(pos)
    board[pos].state
  end

  def flip_square(pos)
    board[pos].flip = true unless square_flag(pos)
  end

  def square_flag(pos)
    board[pos].flag
  end

  def change_flag(flag, pos)
    if flag == "Y"
      if board[pos].flag
        board[pos].flag = false
      else
        board[pos].flag = true
      end
    end
  end

  def translate_pos(string)
    string.split(",").map {|pos|  Integer(pos)}
  end
end



game = Game.new(5)
game.run
