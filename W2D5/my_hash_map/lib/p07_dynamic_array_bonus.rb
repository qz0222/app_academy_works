class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0
      j = i + count
    else
      j = i
    end
    return nil if j > count - 1 || j < 0
    begin
      return @store[j]
    rescue
      nil
    end
  end

  def []=(i, val)
    if i >= count
      j = @count - 1
      until j == i
        self.push(nil)
        j += 1
      end

    end
    @store[i] = val

  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < capacity
      return true if val == @store[i]
      i += 1
    end
    false
  end

  def push(val)
    if @count == capacity
      resize!
    end
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    if @count == capacity
      resize!
    end
    old_array = @store
    self[0] = val
    i = 0
    while i < capacity
      self[i + 1] = old_array[i]
      i += 1
    end
    @count += 1
  end

  def pop
    return nil if @count == 0
    prev = self[@count - 1]
    self[@count - 1] = nil
    @count -= 1
    prev
  end

  def shift
    prev = self[0]
    i = 1
    while i < @count
      self[i - 1] = self[i]
      i += 1
    end
    @count -= 1
    prev
  end

  def first
    self[0]
  end

  def last
    self[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < capacity
      prc.call(self[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    p @store
    p other
    return @store == other
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_length = capacity * 2
    old_array = @store
    @store = StaticArray.new(new_length)
    @count = 0
    i = 0
    while i < old_array.length
      self.push(old_array[i])
      i += 1
    end

  end
end
