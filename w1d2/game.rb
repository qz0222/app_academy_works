require "byebug"
require_relative 'card'
require_relative 'board'
require_relative 'player'
require_relative 'ComputerPlayer'

class Game

attr_accessor :guessed_pos, :size, :board, :player, :revealed_pos

  def initialize (size = 4, player)
    @size = size
    @board = []
    @player = player
    @revealed_pos = []
  end

  def setup_board(size)
    Board.new(size)
  end

  def run
    self.board = setup_board(self.size)
    self.board.populate(self.size)
    self.player.size = self.size
    welcome
    play_game
    play_game until game_over?
    puts "You win!"
  end

  def play_game
    self.player.revealed_pos = self.revealed_pos
    system("clear")
    puts "currrent status"
    board.render
    sleep(1/2)
    puts "first move"
    first_pos = self.player.take_position
    first_value = complete_move(first_pos)
    if self.player.value_hash[first_value].include? (first_pos) == false
      self.player.value_hash[first_value] << first_pos
    end
    board.render

    sleep(1/2)
    puts "second move"
    player.guessed_pos = first_pos
    second_pos = self.player.take_position
    second_value = complete_move(second_pos)
    if self.player.value_hash[second_value].include? (second_pos) == false
      self.player.value_hash[second_value] << second_pos
    end
    board.render
    puts ""
    sleep(1/2)

    if compare_values(first_value, second_value) == false
      board[first_pos].hide
      board[second_pos].hide
    else
      self.revealed_pos << first_pos
      self.revealed_pos << second_pos
    end

    player.guessed_pos = []
    sleep(2)
  end


  def compare_values(v1, v2)
    if v1 == v2
      puts "Good Job! You got a match"
      return true
    else
      puts "Try Again!"
      return false
    end
  end


  def game_over?
    board.won?
  end

  def welcome
    puts "Welcome to the Game."
  end

  def complete_move(pos)
    self.board.reveal(pos)
    return self.board[pos].value
  end

end



if __FILE__==$PROGRAM_NAME
  game = Game.new(4, ComputerPlayer.new("Alex"))
  game.run
end
