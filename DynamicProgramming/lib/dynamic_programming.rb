class DynamicProgramming
  attr_accessor :cache

  def initialize
    @cache = { 1 => 1, 2 => 2 }
    @frog_hops = { 1 => [[1]] }
    @frog_cache = cache = { 1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1],[1,2],[2,1],[3]] }
  end

  def blair_nums(n)
    @cache[n]
  end

  def frog_hops_bottom_up(n)
   @frog_hops[n]
  end

  def frog_cache_builder(n)
    @frog_cache[n]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_hops[n] if @frog_hops[n]
    @frog_hops[n] = []
  end

  def super_frog_hops(n, k)
    return [[1]] if n == 1
    arr = []
    super_frog_hops(n - 1, k).each do |el|
      arr << el + [1]
      if el[-1] + 1 <= k
        arr << el[0...-1] + [el[-1] + 1]
      end 
    end
    return arr 
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
