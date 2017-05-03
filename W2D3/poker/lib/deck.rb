require 'card'

class Deck

  attr_accessor :cards

  def initialize
    @cards = populate_deck
  end

  def populate_deck
    cards = []
    symbols = [:heart, :diamond, :spade, :club]
    special_cards = ["J", "Q", "K", "A"]
    4.times do |i|
      (2..10).each do |num|
        cards << Card.new(num.to_s, symbols[i])
      end
      special_cards.each do |el|
        cards << Card.new(el, symbols[i])
      end
    end
    cards
  end

  def shuffle_deck
    @cards = cards.shuffle
  end

  def give_card
    cards.shift
  end
end
