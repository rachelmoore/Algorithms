require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      el = @map[key]
      update_node!(el)
      el.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    el = @prc.call(key)
    node = @store.append(key, el)
    @map[key] = node
    if @max < count
      eject!
    end
    el
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    last = @store.last
    tail = last.next
    node.next = tail
    node.prev = last
    last.next = node
    tail.prev = node
    return node.val
  end

  def eject!
    first = @store.first
    first.remove
    @map.delete(first.key)
  end
end
