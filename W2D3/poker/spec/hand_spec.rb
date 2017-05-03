require 'hand'
require 'rspec'

describe Hand do

  subject(:hand) { Hand.new }
  describe "#initialize" do

    it "should initialize empty hand of cards" do
      expect(hand.cards).to be_empty
    end

  end

  describe "#get_card" do

    it "should add a card to hand" do
      hand.get_card
      expect(hand.cards.count).to eq(1)
    end
  end


end
