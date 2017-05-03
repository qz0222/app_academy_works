class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    return if @parent == node #don't assign the same parent twice

    node.children << self unless node.nil? #add self to new parent

    unless @parent.nil? #if there's an old parent, remove self from old parent's childre
      @parent.children.each_with_index do |child, i|
        if child == self
          @parent.children.delete_at(i)
          break
        end
      end
    end

    @parent = node #assign self's parent to passed in node
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a child of this node!" unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      node = child.dfs(target_value)
      return node unless node.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end

end
# 
# root_node = PolyTreeNode.new("f")
# node1 = PolyTreeNode.new("r")
# node2 = PolyTreeNode.new("x")
# node3 = PolyTreeNode.new("w")
# node4 = PolyTreeNode.new("g")
#
# node1.parent = root_node
# node2.parent = root_node
#
# p root_node.bfs("x")
# p root_node.bfs("hello")
