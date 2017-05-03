require 'player'
require 'deck'

class Game

  attr_reader :players
  attr_accessor :pot, :deck, :current_player

  def initialize(player1 = Player.new, player2 = Player.new, *players)
    @players = [player1, player2, players]
    @deck = Deck.new
    @pot = 0
    @current_player = player1
  end

  def get_bet(player)
    @pot += player.bet
  end

  def give_player_card
    card = deck.give_card
    @current_player.put_card_in_hand(card)
  end

end
