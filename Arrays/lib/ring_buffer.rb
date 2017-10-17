require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8 
    @length = 0 
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    popped = self[length - 1]
    self[length - 1] =  nil
    @length -= 1
    return popped
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      self.resize!
    end 
    @length += 1
    self[length - 1] = val
  end

  # O(1)
  def shift
    shifted = self[0]
    @start_idx = (start_idx + 1) % @capacity
    @length -= 1
    return shifted
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize! 
    end 
    @length += 1
    @start_idx = (start_idx - 1) % @capacity
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    end
  end

  def resize!
    new_cap = capacity * 2
    new_store = StaticArray.new(new_cap)
    @length.times do |i|  
      new_store[i] = self[i] 
    end 
    @capacity = new_cap
    @store = new_store
    @start_idx = 0 
  end
end
