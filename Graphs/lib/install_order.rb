# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative 'graph'
require_relative 'topological_sort'


def install_order(arr)
  vertex_hsh = {}
  res = []
  max = 0

  arr.each do |tuple|
    vertex_hsh[tuple[0]] = Vertex.new(tuple[0]) unless vertex_hsh[tuple[0]]
    vertex_hsh[tuple[1]] = Vertex.new(tuple[1]) unless vertex_hsh[tuple[1]]
    Edge.new(vertex_hsh[tuple[1]], vertex_hsh[tuple[0]])
    if max < tuple.max
        max = tuple.max 
    end 
  end

  (1..max).each do |i|
    res << i unless vertex_hsh[i]
  end

  return res + topological_sort(vertex_hsh.values).map { |v| v.value }
end
