require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    list = @store[bucket(key)]
    if list.include?(key)
      list.update(key, val)
    else
      if @count == num_buckets
        resize!
      end
      @count += 1
      list.append(key, val)
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if self.include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    # prc ||= Proc.new{|x| x}
    @store.each do |list|
      list.each do |link|
        prc.call(link.key, link.val) unless list.empty?
      end
    end

  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num = num_buckets * 2
    old_store = @store
    @store =  Array.new(num){LinkedList.new}
    @count = 0
    old_store.each do |list|
      # next if arr.empty?
      list.each do |link|
        self.set(link.key, link.val)
      end
    end
    @store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end


# test = HashMap.new(1)
#
# test.set(1, "a")
# test.set(2, "b")
# test.set(5, "c")
# test.set(8, "d")
#
# test.each do |list|
#   p list
# end
