require 'byebug'

class TowersOfHanoi

  attr_accessor :piles, :discs

  def initialize(discs)
    @piles = Array.new(3) {[]}
    @piles[0] = setup_discs(discs)

  end

  def setup_discs(discs)
    (1..discs).to_a
  end

  def move
    input = input_move
    pos = input.split(", ").map {|el| el.to_i}
    x, y = pos

    raise "Cannot select from an empty pile." if piles[x].empty?
    raise "Cannot move large disc onto smaller disc!" if piles[y].empty? == false && piles[x].first > piles[y].first

    move_discs(pos)
  end

  def input_move

  end

  def move_discs(pos)
    x, y = pos
    take_disc = @piles[x].shift
    @piles[y] << take_disc
  end

  def won?
    piles[0].empty? && (piles[1].empty? || piles[2].empty?)
  end


end
