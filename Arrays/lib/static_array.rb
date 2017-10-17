# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    self.store = Array.new(length)
  end

  # O(1)
  def [](index)
    return store[index]
  end

  # O(1)
  def []=(index, value)
    store[index] = value 
  end

  protected
  attr_accessor :store
end