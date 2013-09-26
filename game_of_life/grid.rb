class Grid

  attr_accessor :cells

  def initialize(cells)
    @cells = cells
  end

  def tick
    new_grid = Grid.new(@cells)

    @cells.keys.map do |pos1|
      pos1.neighbours.map do |pos2|
        new_grid.cells[pos2] = true
      end
    end

    new_grid.cells.delete_if do |key, value|
      was_dead = ! @cells.include?(key)
      alive_neighbours = (@cells.keys & key.neighbours).size
       alive_neighbours < 2 || alive_neighbours > 3 ||
      ( was_dead && alive_neighbours == 3 )
    end
    new_grid
  end

end

