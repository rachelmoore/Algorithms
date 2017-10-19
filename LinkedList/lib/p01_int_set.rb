class MaxIntSet
  def initialize(max)
    @max = max 
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
      validate!(num)
    else 
      raise "Out of bounds"
    end 
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false  
    end 
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    if num >= 0 && num <= @max
      return true 
    else 
      return false 
    end 
  end

  def validate!(num)
    @store[num] = true 
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count > num_buckets 
      resize! 
    end 
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= num 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    double_num = 2 * num_buckets
    updated_store = Array.new(double_num ) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        updated_store[num % double_num].push(num)
      end 
    end 
    @store = updated_store
  end
end
