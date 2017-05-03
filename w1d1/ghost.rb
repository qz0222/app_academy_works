class Game

  attr_accessor :dictionary, :player1, :player2, :current_player, :status

  def initialize(player1, player2, filename)
    @player1 = player1
    @player2 = player2
    @fragment = ""
    @dictionary = setup(filename)
    @current_player = player1
    @status = {@player1 => 0, @player2 => 0}
  end

  def setup(filename)
    File.readlines(filename).group_by do |word|
      word.chomp
    end
  end

  def valid_play?(string)
    @dictionary.each_key do |word|
      return true if word[0,string.length] == string
    end
    return false
  end

  def next_player!
    if @current_player == @player2
      @current_player = @player1
    else
      @current_player = @player2
    end
  end

  def take_turn(player)
    t = player.guess
    temp = @fragment + t
    #print temp
    if valid_play?(temp)
      puts "this is a valid play"
      @fragment = temp
    else
      player.alert_invalid_guess
      take_turn(player)
    end
  end

  def play_round
    puts "New Round Start"
    display_standings
    puts "First player is #{@current_player.name}"
    until @dictionary.include?(@fragment)
      puts "the word is: #{@fragment}"
      take_turn(@current_player)
      next_player!
      puts "current player is #{@current_player.name}"
    end
    puts "Loser for this round is: #{@current_player.name}"
  end

  def play
    puts "Game Start"

    until @status.values.include?(5)
      @fragment = ""
      play_round
      @status[@current_player] += 1
    end
    next_player!
    display_standings
    puts "The Winner is: #{@current_player.name}"
  end

  def display_standings
    str = "GHOST"
    puts "#{@player1.name}: #{str[0,@status[@player1]]}"
    puts "#{@player2.name}: #{str[0,@status[@player2]]}"
  end

end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def alert_invalid_guess
    puts "try again!"
  end

  def guess
    puts "please enter your guess:"
    $stdin.gets.chomp
  end

end

if __FILE__ == $PROGRAM_NAME

  game=Game.new(Player.new("Bob"),Player.new("Tom"),ARGV[0])
  game.play
end
