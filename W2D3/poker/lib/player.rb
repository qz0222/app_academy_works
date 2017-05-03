require 'hand'

class Player

  attr_reader :name, :hand
  attr_accessor :pot

  def initialize(name = "Bob", hand = Hand.new)
    @name = name
    @hand = hand
    @pot = 100
  end

  def bet
    amount = input_amount
    raise "not enough money!" if amount > pot
    @pot -= amount
    amount
  end

  def input_amount
    gets.chomp.to_i
  end

  def put_card_in_hand(card)
    @hand.cards << card
  end


end
