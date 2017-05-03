require 'rspec'
require 'tdd'


describe Array do
  let(:arr) { arr = [1, 2, 1, 3, 3]}
  let(:arr2) { arr2 = [-1, 0, 2, -2, 1]}
  let(:arr3) { arr3 = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}
  let(:stocks) { stocks = [1, 2, 3, 4, 5, 4, 3, 2, 1]}
  let(:empty_arr) { empty_arr = []}
  let(:bad_stocks) { bad_stocks = [5, 4, 3, 2, 1]}

  describe "#my_uniq" do
    it "returns an array" do
      expect(arr.my_uniq).to be_is_a(Array)
    end

    it "returns array with removed duplicates" do
      expect(arr.my_uniq).to eq([1, 2, 3])
    end

    it "returns a new array" do
      expect(arr.my_uniq).to be_is_a(Array)
      expect(arr.my_uniq.object_id).not_to eq(arr.object_id)
    end

    it "doesn't call built-in array method 'uniq'" do
      expect(arr).not_to receive(:uniq)
      arr.my_uniq
    end
  end

  describe "#two_sum" do
    it "returns an array" do
      expect(arr2.two_sum).to be_is_a(Array)
    end

    it "returns index pairs that sums to 0" do
        expect(arr2.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns the pairs in smaller index before bigger index order" do
      expect(arr2.two_sum).not_to eq([[4, 0], [3, 2]])
    end
  end

  describe "#my_transpose" do
    it "returns an array" do
      expect(arr3.my_transpose).to be_is_a(Array)
    end

    it "returns a new array" do
      expect(arr3.my_transpose).to be_is_a(Array)
      expect(arr3.my_transpose.object_id).not_to eq(arr3.object_id)
    end

    it "returns transpose array" do
      expect(arr3.my_transpose).to eq([
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ])
    end
  end

  describe "#stock_picker" do
    it "returns an array" do
      expect(stocks.stock_picker).to be_is_a(Array)
    end

    it "returns the most profitable pair of days" do
      expect(stocks.stock_picker).to eq([0, 4])
    end


    it "returns nil if no profitable pair is found" do
      expect(bad_stocks.stock_picker).to eq(nil)
    end

  end


end
