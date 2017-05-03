class Link
  include Enumerable
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
    self.prev = nil
    self.next = nil
  end
end

class LinkedList
  include Enumerable
  def initialize(head = Link.new, tail = Link.new)
    @head = head
    @tail = tail
    @head.next = tail
    @tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if @head.next == @tail
    @head.next
  end

  def last
    return nil if @tail.prev == @head
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current = @head.next
    until current == @tail
      return current.val if current.key == key
      current = current.next
    end
    nil
  end

  def include?(key)
    return false if empty?
    unless get(key).nil?
      return true
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.next = @tail
    new_link.prev = @tail.prev
    @tail.prev.next = new_link
    @tail.prev = new_link
  end

  def update(key, val)
    current = @head.next
    until current == @tail || current.key == key
      current = current.next
    end
    current.val = val
  end

  def remove(key)
    current = @head.next
    until current == @tail
      if current.key == key
        current.remove
        break
      end
      current = current.next
    end
  end

  def each(&prc)
    prc ||= Proc.new{|x| x}
    current = @head.next
    until current == @tail
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
