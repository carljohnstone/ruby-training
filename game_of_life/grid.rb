class Grid

  attr_accessor :cells

  def initialize(cells)
    @cells = cells
  end

  def tick
    new_grid = Grid.new(@cells)

    birth_candidates.map{ |pos| new_grid.cells[pos] = true }

    new_grid.cells.delete_if do |key, value|
      was_dead = ! @cells.include?(key)
      alive_neighbours = (@cells.keys & key.neighbours).size
       alive_neighbours < 2 || alive_neighbours > 3 ||
      ( was_dead && alive_neighbours == 3 )
    end
    new_grid
  end

  def birth_candidates
    all_neighbours = @cells.keys.map{ |pos| pos.neighbours}
    all_neighbours.map{ |pos| pos }.flatten
  end

end

