class Node
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
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev, @prev.next = @prev, @next 
    @next, @prev = nil, nil
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail
  def initialize
    @head, @tail = Node.new, Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    if @head.next == @tail
      return true 
    else 
      return false 
    end 
  end

  def get(key)
    el = @head
    until el.key == key || el == @tail
      el = el.next
    end
    el == @tail ? nil : el.val
  end

  def include?(key)
    !!get(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last
    last.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    el = @head
    until el.key == key || el == @tail
      el = el.next
    end
    if el != @tail
      el.val = val
    end
  end

  def remove(key)
    el = @head
    until el.key == key || el == @tail
      el = el.next
    end
    el.remove if el != @tail
  end

  def each
    el = @head
    until el == last
      el = el.next
      yield(el)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end