class Game

  attr_accessor :players, :current_player, :status
  attr_reader :dictionary

  def initialize(*players, filename)
    @players = players
    @fragment = ""
    @dictionary = setup(filename)
    @current_player = players[0]
    @current_player_index = 0
    @status = setup_status(players)
  end

  def setup(filename)
    File.readlines(filename).group_by do |word|
      word.chomp
    end
  end

  def setup_status(players)
    answer = {}
    players.each do |player|
      answer[player] = 0
    end
    answer
  end

  def setup_players(players)
    players.each{|player|
      player.ai_dictionary = @dictionary if player.is_a?(Aiplayer)
    }
  end

  def valid_play?(string)
    @dictionary.each_key do |word|
      return true if word[0,string.length] == string
    end
    return false
  end

  def next_player!
    @current_player_index = (@current_player_index + 1) % @players.length
    @current_player = @players[@current_player_index]
  end

  def take_turn(player)
    if player.is_a?(Player)
      t = player.guess
    else
      t = player.ai_guess(@fragment, @players.length)
    end
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
    take_turn(@current_player)
    until @dictionary.include?(@fragment)
      puts "-------------------------------------------------"
      next_player!
      puts "current player is #{@current_player.name}"
      puts "the word is: #{@fragment}"
      take_turn(@current_player)
    end
    display_standings
    puts "Loser for this round is: #{@current_player.name}"
    puts "-------------------------------------------------"
  end

  def play
    puts "Game Start"
    setup_players(@players)
    until @players.length == 1
      until @status.values.include?(5)
        @fragment = ""
        play_round
        @status[@current_player] += 1
      end
      puts "#{@current_player.name} is out"
      @status.delete(@current_player)
      @players.delete_at(@current_player_index)
      @current_player_index = @current_player_index % @players.length
      @current_player = @players[@current_player_index]
    end
    puts "The Winner is: #{@current_player.name}"
  end

  def display_standings
    str = "GHOST"
    @players.each do |player|
      puts "#{player.name}: #{str[0,@status[player]]}"
    end
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

class Aiplayer
  attr_accessor :ai_dictionary
  attr_reader :name

  def initialize(name)
    @name = name
    @ai_dictionary = {}
  end

  def ai_guess(str,num)
    update_dictionary(str)
    losing_words = []
    winning_words = []
    unknown_words = []
    @ai_dictionary.each_key{|key|
      if key.length - str.length == 1
        losing_words << key[str.length]
      elsif key.length - str.length <= num
        winning_words << key[str.length]
      else
        unknown_words << key[str.length]
      end
    }
    if winning_words.empty?
      if unknown_words.empty?
        guess = losing_words.sample
      else
        guess = unknown_words.sample
      end
    else
      guess = winning_words.sample
    end
    puts "#{@name}'s guess is: #{guess}"
    return guess


  end

  def update_dictionary(str)
    @ai_dictionary.each_key do |key|
      @ai_dictionary.delete(key) unless key[0,str.length] == str
    end
  end

end

if __FILE__ == $PROGRAM_NAME

  game=Game.new(Aiplayer.new("Robert"),Aiplayer.new("Tom"),Player.new("Sally"),ARGV[0])
  game.play
end
