class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length 
  end

  def extract
    first = @store[0]
    @store[0] = @store.pop 
    self.class.heapify_down(@store, 0, &prc)
    return first 
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val 
    self.class.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    first_child = (parent_index * 2) + 1
    second_child = (parent_index * 2) + 2
    [first_child, second_child].select do |i|
      i < len 
    end 
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    children = child_indices(len, parent_idx) || []
    first_child, second_child = children
    children = children.map do |idx| 
      array[idx] 
    end 

    return array if children.all? { |child| prc.call(array[parent_idx], child) <= 0 }

    smaller_idx = first_child
    if children.length != 1
        if prc.call(children[0], children[1]) == -1 
          smaller_idx = first_child 
        else 
          smaller_idx = second_child
        end 
    end

    array[parent_idx], array[smaller_idx] = array[smaller_idx], array[parent_idx]
    heapify_down(array, smaller_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]
    return array unless prc.call(child_val, parent_val) < 0
    array[child_idx], array[parent_idx] = parent_val, child_val
    heapify_up(array, parent_idx, len, &prc)
  end
end
