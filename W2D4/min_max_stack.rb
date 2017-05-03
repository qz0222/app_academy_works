require "byebug"

class MyQueue
  attr_accessor :store

  def initialize
    @store = []
  end

  def enqueue(el)
    store << el
  end

  def dequeue
    store.shift
  end

  def peek
    store.first
  end

  def empty?
    store.empty?
  end

  def size
    store.length
  end
end

class MinMaxStack
  attr_accessor :store, :biggest, :smallest

  def initialize
    @store = []
    @biggest = []
    @smallest = []
  end

  def pop
    x = store.pop
    biggest.pop if biggest.last == x
    smallest.pop if smallest.last == x
    x
  end

  def push(el)
    biggest << el if biggest.empty? || el >= biggest.last
    smallest << el if smallest.empty? || el <= smallest.last
    store.push(el)
  end

  def max
    biggest.last
  end

  def min
    smallest.last
  end

  def peek
    store.last
  end

  def size
    store.length
  end

  def empty?
    store.empty?
  end
end

class MyStack
  attr_accessor :store

  def initialize
    @store = []
  end

  def pop
    x = store.pop
  end

  def push(el)
    store.push(el)
  end

  def peek
    store.last
  end

  def size
    store.length
  end

  def empty?
    store.empty?
  end
end

class MinMaxStackQueue
  attr_accessor :stack1, :stack2

  def initialize
    @stack1 = MinMaxStack.new
    @stack2 = MinMaxStack.new
  end

  def enqueue(el)
    stack1.push(el)
  end

  def dequeue
    if stack2.empty?
      until stack1.empty?
        stack2.push(stack1.pop)
      end
    end
    stack2.pop
  end

  def max
    return stack1.max if stack2.max.nil?
    return stack2.max if stack1.max.nil?
    stack1.max > stack2.max ? stack1.max : stack2.max
  end

  def min
    return stack1.min if stack2.min.nil?
    return stack2.min if stack1.min.nil?
    stack1.min < stack2.min ? stack1.min : stack2.min
  end

  def size
    stack1.size + stack2.size
  end

  def empty?
    stack1.empty? && stack2.empty?
  end
end

# stack = MinMaxStackQueue.new
# stack.enqueue(3)
# stack.enqueue(20)
# stack.enqueue(200)
# stack.enqueue(-3)
# stack.enqueue(12)
#
# stack.dequeue
# puts stack.max
#
# puts stack.min
# stack.dequeue
# stack.dequeue
# puts stack.max
# puts stack.min
