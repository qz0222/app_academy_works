require 'byebug'
require_relative '00_tree_node'

class KnightPathFinder
  DELTAS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  attr_reader :visited_positions, :start_position, :root_node

  def initialize(pos)
    @visited_positions = [pos]
    @start_position = pos
    # return if @visited_positions.length == 64
    # @prev_move = nil
    # @next_moves = new_move_positions(pos)
    @root_node = PolyTreeNode.new(pos)
  end

  def prev_move=(node)
    return if @prev_move == node #don't assign the same prev_move twice

    node.next_moves << self unless node.nil? #add self to new prev_move

    unless @prev_move.nil? #if there's an old prev_move, remove self from old prev_move's childre
      @prev_move.next_moves.each_with_index do |child, i|
        if child == self
          @prev_move.next_moves.delete_at(i)
          break
        end
      end
    end

    @prev_move = node #assign self's prev_move to passed in node
  end

  def add_child(child_node)
    child_node.prev_move = self
  end

  def remove_child(child_node)
    raise "Not a child of this node!" unless next_moves.include?(child_node)
    child_node.prev_move = nil
  end
  #
  # def dfs(target_value)
  #   return self if self.value == target_value
  #   self.next_moves.each do |child|
  #     node = child.dfs(target_value)
  #     return node unless node.nil?
  #   end
  #   nil
  # end
  #
  def self.valid_moves(pos)
    x, y = pos
    result = DELTAS.map do |x2, y2|
      next unless (0..7).include?(x + x2) && (0..7).include?(y + y2)
      [x + x2, y + y2]
    end
    result.compact
  end

  def new_move_positions(pos)
    new_move_positions = KnightPathFinder.valid_moves(pos).reject do |el|
      @visited_positions.include?(el)
    end

    new_move_positions.each do |new_pos|
      @visited_positions << new_pos
    end
    new_move_positions
  end

  def build_move_tree
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |pos|
        child_node = PolyTreeNode.new(pos)
        queue << child_node
        child_node.parent = current_node
      end
      #
      # if current_position == end_pos
      #   return @visited_positions
      # end
      # queue += create_path_finders(next_moves)
    end
    nil
    # create_path_finders(@next_moves)
  end

  # def bfs(target_value)
  #   queue = [self]
  #   until queue.empty?
  #     node = queue.shift
  #     return node if node.value == target_value
  #     queue += node.next_moves
  #   end
  #   nil
  # end

  # def create_path_finders(array_of_pos)
  #   result = []
  #   array_of_pos.each do |pos|
  #     result << KnightPathFinder.new(pos, @visited_positions)
  #   end
  #   result
  # end

  def find_path(end_pos)
    last_node = root_node.dfs(end_pos)
    trace_path_back(last_node)
  end

  def trace_path_back(node)
    path = []
    current_node = node
    until current_node.value == start_position
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(start_position)
  end

end

k = KnightPathFinder.new([0,0])
k.build_move_tree
p k.find_path([7,6])
p k.find_path([6,2])
