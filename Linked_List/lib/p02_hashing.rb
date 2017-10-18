class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = 0 
    self.each_with_index do |el, i|
      el = el.hash 
      res += el ^ (10 ** i)
    end 
    res.hash 
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a 
    arr.sort_by(&:hash).hash
  end
end
