class Position

  attr_accessor :x,:y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def neighbours
    neighbours = Array.new
    (@x-1 .. @x+1).each do |x|
      (@y-1 .. @y+1).each do |y|
        neighbours.push(Position.new(x,y)) unless (x == @x && y == @y)
      end
    end
    neighbours
  end

  def hash
    [@x, @y].hash
  end

  def ==(pos2)
    @x == pos2.x && @y == pos2.y
  end

end
