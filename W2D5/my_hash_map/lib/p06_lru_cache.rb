require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc = Proc.new { |x| x ** 2 })
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    # prc ||= Proc.new { |x| x ** 2 }
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map.get(key))
    else
     calc!(key)
    end
    @store.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.append(key,val)
    if count == @max
      eject!
    end
    @map.set(key, @store.last)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.append(link.key, link.val)
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end
