require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |el1, el2| el2 <=> el1 }
    len = self.length
    (1...len).each do |i|
      BinaryMinHeap.heapify_up(self, i, &prc)
    end
    (1...len).each do |i|
      self[0], self[self.length - i] = self[self.length - i], self[0]
      BinaryMinHeap.heapify_down(self, 0, len - i, &prc)
    end
  end
end
