class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 1
    arr = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      if el <= arr
        left << el
      else
        right << el
      end
    end
    return self.class.sort1(left) + [arr] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 1
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot - start, &prc)
    QuickSort.sort2!(array, pivot + 1, length - pivot - 1, &prc)
    return array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    idx = start + 1
    (1...length).each do |i|
      if prc.call(array[start + i], array[start]) < 1
        array[start + i], array[idx] = array[idx], array[start + i]
        idx += 1
      end
    end
    array[start], array[idx - 1] = array[idx - 1], array[start]
    idx -= 1
  end
end
