require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  hsh = HashMap.new 
  arr = string.chars
  arr.each do |el|
    if hsh[el]
        hsh[el] += 1 
    else 
        hsh[el] = 0 
    end 
  end

  count = 0 
  hsh.each do |k, v|
    if v % 2 == 0 
        count += 1 
    end
  end 

  if count == hsh.count 
    return true 
  else 
    return false 
  end
end
