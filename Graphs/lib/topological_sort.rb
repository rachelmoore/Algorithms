require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
    edges_hsh = {}
    sorted = []
    arr = [] 

    vertices.each do |vertex|
        edges_hsh[vertex] = vertex.in_edges.count 
        if vertex.in_edges.empty? 
            arr << vertex 
        end 
    end 

    while arr.length > 0
        pres_vertex = arr.shift
        sorted << pres_vertex 

        pres_vertex.out_edges.each do |edge|
        to_vertex = edge.to_vertex

        edges_hsh[to_vertex] -= 1
        if edges_hsh[to_vertex] == 0
            arr << to_vertex
        end
    end
  end

    if sorted.length == vertices.length 
        return sorted 
    else 
        return [] 
    end 
end
