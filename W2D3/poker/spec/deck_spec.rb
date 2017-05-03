require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do

  end

  describe "#populate_deck" do

    it "should return a deck of 54 cards" do
      expect(deck.cards.count).to eq(52)
      expect(deck.cards.all?{|card| card.is_a?(Card)}).to be(true)
    end

    it "should have 13 unique cards for each symbol" do
      expect(deck.cards.select{|card| card.symbol == :heart}.count).to eq(13)
      expect(deck.cards.select{|card| card.symbol == :diamond}.count).to eq(13)
      expect(deck.cards.select{|card| card.symbol == :spade}.count).to eq(13)
      expect(deck.cards.select{|card| card.symbol == :club}.count).to eq(13)
    end
  end

  describe "shuffle_deck" do

    it "should shuffle the deck" do
      prev_deck = deck.cards.dup
      deck.shuffle_deck
      expect(deck.cards).not_to eq(prev_deck)
    end
  end

  describe "#give_card" do
    it "should return top card of the deck" do
      top_card = deck.cards[0]
      expect(deck.give_card).to eq(top_card)
    end

    it "should remove the top card from the deck" do
      top_card = deck.cards[0]
      deck.give_card
      expect(deck.cards.include?(top_card)).to be_falsey
    end
  end


end
