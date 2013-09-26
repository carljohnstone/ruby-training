require "spec_helper"

describe "Grid" do

  p0_1 = Position.new(0,1)
  p1_1 = Position.new(1,1)
  p1_0 = Position.new(1,0)
  p2_0 = Position.new(2,0)

  it "has live cells" do
    grid = Grid.new({ p1_1 => true })
    expect(grid.class).to eq Grid
    expect(grid.cells.size).to eq 1
  end

  it "can tick" do
    grid = Grid.new({ p1_1 => true })
    new_grid = grid.tick
    expect(new_grid.class).to eq Grid
  end

  it "can kill underpopulated cells" do
    grid = Grid.new({ p1_1 => true })
    new_grid = grid.tick
    expect(new_grid.cells).to eq Hash.new
  end

  it "can kill underpopulated cells" do
    grid = Grid.new({ p0_1 => true, p1_0 => true, p2_0 => true })
    new_grid = grid.tick
    expect(new_grid.cells).to eq Hash.new({ p0_1 => true, p1_1 => true })
  end

end

