require 'card'
require 'rspec'



describe Card do
  describe "#initialize" do

    context "when initialized with a 4 of hearts" do
      let(:card) { Card.new("4", :heart) }
      
      before(:each) do

      end

      it "should start with a value" do
        expect(card.value).to eq("4")
      end

      it "should have a symbol" do
        expect(card.symbol).to eq(:heart)
      end

    end

  end

end
