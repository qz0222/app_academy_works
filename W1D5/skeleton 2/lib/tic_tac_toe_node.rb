require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @prev_move_pos = prev_move_pos
    @next_mover_mark = next_mover_mark
    @board = board
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    board.rows.flatten.each do |pos|
      if pos.nil?
    end
  end
end
