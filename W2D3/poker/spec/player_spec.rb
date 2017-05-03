require 'player'
require 'rspec'

describe Player do

  let(:hand) {double("hand", :cards => [])}
  subject(:player) {Player.new("Bob", hand)}

  describe "#initialize" do
    it "should take a name from player" do
      expect(player.name).to eq("Bob")
    end

    it "should start with an empty hand" do
      expect(player.hand.cards).to be_empty
    end

    it "should start with a pot that is not empty" do
      expect(player.pot).not_to eq(0)
    end
  end

  describe "#bet" do

    it "should raise error if bet amount is over the pot" do
      allow(player).to receive(:input_amount).and_return(120)
      expect{player.bet}.to raise_error("not enough money!")
    end

    it "should subtract the amount of money from pot" do
      allow(player).to receive(:input_amount).and_return(80)
      player.bet
      expect(player.pot).to eq(20)
    end

    it "should return the bet amount" do
      allow(player).to receive(:input_amount).and_return(10)
      expect(player.bet).to eq(10)
    end
  end

  describe "#discard" do
    
  end

end
