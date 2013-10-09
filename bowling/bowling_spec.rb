describe "Bowling" do
  it "adds up a game with no strikes or spares" do
    game = Game.new( Array.new(20) { 1 } )
    expect(game.total_score).to eq 20
  end
  
end

class Game

  def initialize( scores )
    @scores = scores
  end

  def total_score
    @scores.reduce(0) { |s, tot| tot += s }
  end
end
