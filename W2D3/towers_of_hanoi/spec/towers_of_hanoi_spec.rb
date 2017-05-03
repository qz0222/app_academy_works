require 'towers_of_hanoi'


describe TowersOfHanoi do
  subject(:game) { game = TowersOfHanoi.new(3) }

  describe "#initialize" do
    it "initializes with 3 piles" do
      expect(game.piles.count).to eq(3)
    end

    it "starts with three arrays in piles" do
      expect(game.piles.all? {|el| el.is_a?(Array)}).to eq(true)
    end

    it "initializes with a number of discs in the first pile" do
      expect(game.piles[0].length).not_to eq(0)
    end

    it "sets the discs up in ascending order" do
      expect(game.piles[0]).to eq(game.piles[0].sort)
    end
  end

  describe "#move" do

    context "When given a move" do
      before(:each) do
        allow(game).to receive(:input_move).and_return("0, 1")
      end

      it "prompts player for input" do
        expect(game).to receive(:input_move).at_least(:once)
        game.move
      end
    end

    context "When given a valid move" do
      before(:each) do
        allow(game).to receive(:input_move).and_return("0, 1")
        game.move
      end

      it "pops the disc off of first tower" do
        expect(game.piles[0].length).to eq(2)
      end

      it "pushes the disc on to another tower" do
        expect(game.piles[1].length).to eq(1)
      end

      it "moves discs from one pile to another" do
        expect(game.piles[0].length).to eq(2)
        expect(game.piles[1].length).to eq(1)
      end

    end

    context "When given an invalid move" do
      before(:each) do
        allow(game).to receive(:input_move).and_return("0, 1")
        game.move
        allow(game).to receive(:input_move).and_return("0, 1")
      end

      it "will not move bigger disc onto smaller disc" do
        expect {game.move}.to raise_error("Cannot move large disc onto smaller disc!")
      end

      it "will not select a disc from an empty pile" do
        allow(game).to receive(:input_move).and_return("2, 0")
        expect {game.move}.to raise_error("Cannot select from an empty pile.")
      end
    end
  end

  describe "#won?" do
    context "When a pile is complete" do
      before(:each) do
        game.piles[2] = [2, 3]
        game.piles[1] = []
        game.piles[0] = [1]
        allow(game).to receive(:input_move).and_return("0, 2")
      end

      it "returns true if game is over" do
        game.move
        expect(game.won?).to eq(true)
      end
    end

  end
end
