require "game"
require 'rspec'

describe Game do
  subject(:game) { Game.new()}

  describe "#initialize" do
    it "should start with at least two players" do
      expect(game.players.count >= 2).to be_truthy
    end

    it "should start with a deck" do
      expect(game.deck).to be_is_a(Deck)
    end

    it "should start with empty pot" do
      expect(game.pot).to eq(0)
    end

    it "should know who's turn it is" do
      expect(game.current_player).to eq(game.players.first)
    end
  end

  describe "#get_bet" do
    let(:player) {double("player", :bet => 10) }
    it "should get amount from player" do
      expect(player).to receive(:bet)
      game.get_bet(player)
    end

    it "should add bet amount to the pot" do
      game.get_bet(player)
      expect(game.pot).to eq(10)
    end
  end

  # describe "#give_player_card" do
  #   it "should give card to player's hand" do
  #     let(:fake_card) { double("fake_card")}
  #     allow(:deck).to receive(:give_card).and_return(:fake_card))
  #
  #   end
  # end

end
